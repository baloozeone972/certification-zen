// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/billing/BillingClientWrapper.kt
package com.certifapp.android.data.billing

import android.app.Activity
import android.content.Context
import com.android.billingclient.api.*
import dagger.hilt.android.qualifiers.ApplicationContext
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.suspendCancellableCoroutine
import javax.inject.Inject
import javax.inject.Singleton
import kotlin.coroutines.resume

/**
 * Wrapper Google Play Billing Library 6.x.
 * Gère les abonnements PRO (9,99€/mois) et le Pack certif (4,99€ achat unique).
 * Singleton Hilt — initialisé au démarrage de l'app.
 */
@Singleton
class BillingClientWrapper @Inject constructor(
    @ApplicationContext private val context: Context
) : PurchasesUpdatedListener {

    companion object {
        /** SKU de l'abonnement mensuel Pro — à créer dans la Play Console */
        const val SKU_PRO_MONTHLY = "certifapp_pro_monthly"
        /** SKU de l'achat unique Pack certification */
        const val SKU_PACK_CERT   = "certifapp_pack_cert"
    }

    // ── État réactif ──────────────────────────────────────────────────────────

    private val _purchases = MutableStateFlow<List<Purchase>>(emptyList())
    val purchases: StateFlow<List<Purchase>> = _purchases.asStateFlow()

    private val _isProActive = MutableStateFlow(false)
    val isProActive: StateFlow<Boolean> = _isProActive.asStateFlow()

    private val _billingError = MutableStateFlow<String?>(null)
    val billingError: StateFlow<String?> = _billingError.asStateFlow()

    // ── BillingClient ─────────────────────────────────────────────────────────

    private val billingClient: BillingClient = BillingClient.newBuilder(context)
        .setListener(this)
        .enablePendingPurchases(
            PendingPurchasesParams.newBuilder().enableOneTimeProducts().build()
        )
        .build()

    // ── Connexion ─────────────────────────────────────────────────────────────

    /** Se connecte à Google Play et charge les achats existants. */
    fun connect(onConnected: () -> Unit = {}) {
        billingClient.startConnection(object : BillingClientStateListener {
            override fun onBillingSetupFinished(result: BillingResult) {
                if (result.responseCode == BillingClient.BillingResponseCode.OK) {
                    onConnected()
                    queryExistingPurchases()
                } else {
                    _billingError.value = "Billing setup failed: ${result.debugMessage}"
                }
            }
            override fun onBillingServiceDisconnected() {
                // La reconnexion sera tentée au prochain appel
            }
        })
    }

    // ── Produits ──────────────────────────────────────────────────────────────

    /** Charge les détails des produits (prix, titre) depuis Play Store. */
    suspend fun queryProductDetails(): List<ProductDetails> {
        val params = QueryProductDetailsParams.newBuilder()
            .setProductList(listOf(
                QueryProductDetailsParams.Product.newBuilder()
                    .setProductId(SKU_PRO_MONTHLY)
                    .setProductType(BillingClient.ProductType.SUBS)
                    .build(),
                QueryProductDetailsParams.Product.newBuilder()
                    .setProductId(SKU_PACK_CERT)
                    .setProductType(BillingClient.ProductType.INAPP)
                    .build()
            ))
            .build()

        return suspendCancellableCoroutine { continuation ->
            billingClient.queryProductDetailsAsync(params) { result, productDetailsList ->
                if (result.responseCode == BillingClient.BillingResponseCode.OK) {
                    continuation.resume(productDetailsList)
                } else {
                    continuation.resume(emptyList())
                }
            }
        }
    }

    // ── Achat ─────────────────────────────────────────────────────────────────

    /** Lance le flow d'achat Google Play pour un produit. */
    fun launchBillingFlow(activity: Activity, productDetails: ProductDetails): BillingResult {
        val productDetailsParamsList = if (productDetails.productType == BillingClient.ProductType.SUBS) {
            val offerToken = productDetails.subscriptionOfferDetails?.firstOrNull()?.offerToken ?: ""
            listOf(
                BillingFlowParams.ProductDetailsParams.newBuilder()
                    .setProductDetails(productDetails)
                    .setOfferToken(offerToken)
                    .build()
            )
        } else {
            listOf(
                BillingFlowParams.ProductDetailsParams.newBuilder()
                    .setProductDetails(productDetails)
                    .build()
            )
        }

        val billingFlowParams = BillingFlowParams.newBuilder()
            .setProductDetailsParamsList(productDetailsParamsList)
            .build()

        return billingClient.launchBillingFlow(activity, billingFlowParams)
    }

    // ── Callback achats ───────────────────────────────────────────────────────

    override fun onPurchasesUpdated(result: BillingResult, purchases: List<Purchase>?) {
        when (result.responseCode) {
            BillingClient.BillingResponseCode.OK -> {
                purchases?.forEach { purchase ->
                    handlePurchase(purchase)
                }
            }
            BillingClient.BillingResponseCode.USER_CANCELED -> {
                // Annulation utilisateur — pas d'erreur
            }
            else -> {
                _billingError.value = "Purchase error: ${result.debugMessage}"
            }
        }
    }

    private fun handlePurchase(purchase: Purchase) {
        if (purchase.purchaseState == Purchase.PurchaseState.PURCHASED) {
            // Confirmer l'achat (obligatoire dans les 3 jours sinon remboursement automatique)
            if (!purchase.isAcknowledged) {
                acknowledgePurchase(purchase.purchaseToken)
            }
            val isProSku = purchase.products.contains(SKU_PRO_MONTHLY)
            val isPackSku = purchase.products.contains(SKU_PACK_CERT)
            if (isProSku || isPackSku) {
                _isProActive.value = true
            }
            _purchases.value = _purchases.value + purchase
        }
    }

    private fun acknowledgePurchase(purchaseToken: String) {
        val params = AcknowledgePurchaseParams.newBuilder()
            .setPurchaseToken(purchaseToken)
            .build()
        billingClient.acknowledgePurchase(params) { result ->
            if (result.responseCode != BillingClient.BillingResponseCode.OK) {
                _billingError.value = "Acknowledge failed: ${result.debugMessage}"
            }
        }
    }

    // ── Restauration ──────────────────────────────────────────────────────────

    private fun queryExistingPurchases() {
        billingClient.queryPurchasesAsync(
            QueryPurchasesParams.newBuilder()
                .setProductType(BillingClient.ProductType.SUBS)
                .build()
        ) { _, purchases ->
            val activeSubs = purchases.filter { it.purchaseState == Purchase.PurchaseState.PURCHASED }
            if (activeSubs.isNotEmpty()) {
                _isProActive.value = true
                _purchases.value = activeSubs
            }
        }
    }

    fun disconnect() {
        if (billingClient.isReady) billingClient.endConnection()
    }
}
