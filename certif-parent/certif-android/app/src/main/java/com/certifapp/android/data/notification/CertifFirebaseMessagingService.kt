// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/notification/CertifFirebaseMessagingService.kt
package com.certifapp.android.data.notification

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import androidx.core.app.NotificationCompat
import com.certifapp.android.MainActivity
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import dagger.hilt.android.AndroidEntryPoint
import javax.inject.Inject

/**
 * Firebase Cloud Messaging service — reçoit les push notifications.
 *
 * Types de notifications gérés :
 * - COACH_REPORT  : rapport hebdomadaire du coach IA (lundi 08h00)
 * - CHALLENGE     : rappel challenge de la semaine
 * - REVIEW_DUE    : flashcards à réviser aujourd'hui
 * - STREAK        : maintien de la série quotidienne
 *
 * Équivalent iOS : APNs via NotificationService.swift
 */
@AndroidEntryPoint
class CertifFirebaseMessagingService : FirebaseMessagingService() {

    companion object {
        const val CHANNEL_COACH    = "certifapp_coach"
        const val CHANNEL_REVIEW   = "certifapp_review"
        const val CHANNEL_CHALLENGE = "certifapp_challenge"

        /** Crée les canaux de notification (Android 8+). Appeler au démarrage de l'app. */
        fun createNotificationChannels(context: Context) {
            val manager = context.getSystemService(NotificationManager::class.java)
            listOf(
                NotificationChannel(CHANNEL_COACH, "Coach IA",
                    NotificationManager.IMPORTANCE_DEFAULT).apply {
                    description = "Rapports hebdomadaires et conseils personnalisés"
                },
                NotificationChannel(CHANNEL_REVIEW, "Révisions",
                    NotificationManager.IMPORTANCE_HIGH).apply {
                    description = "Flashcards et rappels de révision quotidiens"
                },
                NotificationChannel(CHANNEL_CHALLENGE, "Challenges",
                    NotificationManager.IMPORTANCE_DEFAULT).apply {
                    description = "Challenges de la semaine et classements"
                }
            ).forEach { manager.createNotificationChannel(it) }
        }
    }

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        val data  = remoteMessage.data
        val notif = remoteMessage.notification

        val type    = data["type"] ?: "GENERIC"
        val title   = notif?.title ?: data["title"] ?: "CertifApp"
        val body    = notif?.body  ?: data["body"]  ?: ""
        val deepLink = data["deepLink"]

        showNotification(type, title, body, deepLink)
    }

    override fun onNewToken(token: String) {
        // Envoyer le nouveau token FCM au backend pour mettre à jour l'utilisateur
        // Le token est envoyé via l'API : PATCH /api/v1/users/fcm-token
        sendTokenToServer(token)
    }

    private fun showNotification(type: String, title: String, body: String, deepLink: String?) {
        val channelId = when (type) {
            "COACH_REPORT" -> CHANNEL_COACH
            "REVIEW_DUE"   -> CHANNEL_REVIEW
            "CHALLENGE"    -> CHANNEL_CHALLENGE
            else           -> CHANNEL_COACH
        }

        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            deepLink?.let { putExtra("deepLink", it) }
        }

        val pendingIntent = PendingIntent.getActivity(
            this, System.currentTimeMillis().toInt(), intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification = NotificationCompat.Builder(this, channelId)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setContentTitle(title)
            .setContentText(body)
            .setStyle(NotificationCompat.BigTextStyle().bigText(body))
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .build()

        val manager = getSystemService(NotificationManager::class.java)
        manager.notify(System.currentTimeMillis().toInt(), notification)
    }

    private fun sendTokenToServer(token: String) {
        // Implémentation via Retrofit — injecté via WorkManager pour éviter
        // les appels réseau directs dans le Service
        // Le SyncWorker enverra le token lors de la prochaine synchronisation
        getSharedPreferences("certifapp_prefs", Context.MODE_PRIVATE)
            .edit()
            .putString("pending_fcm_token", token)
            .apply()
    }
}
