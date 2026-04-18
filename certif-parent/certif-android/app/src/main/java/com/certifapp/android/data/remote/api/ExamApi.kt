// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/remote/api/ExamApi.kt
package com.certifapp.android.data.remote.api

import com.certifapp.android.data.remote.dto.*
import retrofit2.http.*

/** Retrofit interface for exam session endpoints. */
interface ExamApi {
    @POST("exams/sessions")
    suspend fun startSession(@Body request: StartExamRequest): ApiResponse<ExamSessionDto>

    @POST("exams/sessions/{id}/answers")
    suspend fun submitAnswer(
        @Path("id") sessionId: String,
        @Body request: SubmitAnswerRequest
    ): ApiResponse<Any>

    @POST("exams/sessions/{id}/submit")
    suspend fun submitExam(@Path("id") sessionId: String): ApiResponse<ExamSessionDto>

    @GET("exams/sessions/{id}/results")
    suspend fun getResults(@Path("id") sessionId: String): ApiResponse<ExamSessionDto>
}
