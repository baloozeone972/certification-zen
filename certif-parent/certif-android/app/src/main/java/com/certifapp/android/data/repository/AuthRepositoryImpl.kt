// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/repository/AuthRepositoryImpl.kt
package com.certifapp.android.data.repository

import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import com.certifapp.android.data.remote.api.AuthApi
import com.certifapp.android.domain.model.TokenPair
import com.certifapp.android.domain.model.User
import com.certifapp.android.domain.model.SubscriptionTier
import com.certifapp.android.domain.repository.AuthRepository
import kotlinx.coroutines.flow.firstOrNull
import kotlinx.coroutines.runBlocking
import org.json.JSONObject
import android.util.Base64
import javax.inject.Inject

private val KEY_ACCESS = stringPreferencesKey("access_token")
private val KEY_REFRESH = stringPreferencesKey("refresh_token")

/**
 * Auth repository — stores JWT tokens in DataStore (encrypted at rest on Android 6+).
 */
class AuthRepositoryImpl @Inject constructor(
    private val api: AuthApi,
    private val dataStore: DataStore<Preferences>
) : AuthRepository {

    override suspend fun login(email: String, password: String): TokenPair {
        val res = api.login(mapOf("email" to email, "password" to password)).data
        saveTokens(res.accessToken, res.refreshToken)
        return TokenPair(res.accessToken, res.refreshToken, res.expiresIn)
    }

    override suspend fun register(email: String, password: String): TokenPair {
        val res = api.register(mapOf("email" to email, "password" to password, "locale" to "fr")).data
        saveTokens(res.accessToken, res.refreshToken)
        return TokenPair(res.accessToken, res.refreshToken, res.expiresIn)
    }

    override suspend fun logout() {
        dataStore.edit { prefs ->
            prefs.remove(KEY_ACCESS)
            prefs.remove(KEY_REFRESH)
        }
    }

    override fun getStoredUser(): User? {
        val token = runBlocking { dataStore.data.firstOrNull()?.get(KEY_ACCESS) } ?: return null
        return decodeUserFromToken(token)
    }

    override fun isLoggedIn(): Boolean {
        val token = runBlocking { dataStore.data.firstOrNull()?.get(KEY_ACCESS) } ?: return false
        return try {
            val payload = decodePayload(token)
            val exp = payload.optLong("exp", 0L)
            exp > System.currentTimeMillis() / 1000
        } catch (e: Exception) {
            false
        }
    }

    private suspend fun saveTokens(access: String, refresh: String) {
        dataStore.edit { prefs ->
            prefs[KEY_ACCESS] = access
            prefs[KEY_REFRESH] = refresh
        }
    }

    private fun decodeUserFromToken(token: String): User? = try {
        val payload = decodePayload(token)
        User(
            id = payload.getString("sub"),
            email = payload.optString("email", ""),
            role = payload.optString("role", "USER"),
            subscriptionTier = SubscriptionTier.valueOf(payload.optString("tier", "FREE")),
            locale = payload.optString("locale", "fr"),
            timezone = payload.optString("timezone", "Europe/Paris")
        )
    } catch (e: Exception) {
        null
    }

    private fun decodePayload(token: String): JSONObject {
        val parts = token.split(".")
        val decoded = Base64.decode(parts[1], Base64.URL_SAFE or Base64.NO_PADDING)
        return JSONObject(String(decoded))
    }
}
