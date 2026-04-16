// certif-parent/certif-android/app/src/main/java/com/certifapp/android/CertifApp.kt
package com.certifapp.android

import android.app.Application
import androidx.hilt.work.HiltWorkerFactory
import androidx.work.Configuration
import dagger.hilt.android.HiltAndroidApp
import javax.inject.Inject

/**
 * Application entry point — Hilt DI + WorkManager configuration.
 * Virtual Threads not applicable on Android; Kotlin Coroutines used throughout.
 */
@HiltAndroidApp
class CertifApp : Application(), Configuration.Provider {

    @Inject
    lateinit var workerFactory: HiltWorkerFactory

    override val workManagerConfiguration: Configuration
        get() = Configuration.Builder()
            .setWorkerFactory(workerFactory)
            .build()
}
