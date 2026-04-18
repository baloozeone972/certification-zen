// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/remote/api/LearningApi.kt
package com.certifapp.android.data.remote.api

import com.certifapp.android.data.remote.dto.ApiResponse
import com.certifapp.android.data.remote.dto.FlashcardDto
import com.certifapp.android.data.remote.dto.ReviewFlashcardRequest
import retrofit2.http.*

/** Retrofit interface for learning endpoints. */
interface LearningApi {
    @GET("learning/flashcards/{certId}")
    suspend fun getFlashcardsDue(
        @Path("certId") certId: String,
        @Query("limit") limit: Int = 20
    ): ApiResponse<List<FlashcardDto>>

    @POST("learning/flashcards/{id}/review")
    suspend fun reviewFlashcard(
        @Path("id") id: String,
        @Body request: ReviewFlashcardRequest
    ): ApiResponse<Any>
}
