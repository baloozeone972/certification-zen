// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/remote/api/AuthApi.kt
package com.certifapp.android.data.remote.api

import com.certifapp.android.data.remote.dto.ApiResponse
import com.certifapp.android.data.remote.dto.TokenResponseDto
import retrofit2.http.Body
import retrofit2.http.POST

/** Retrofit interface for authentication endpoints. */
interface AuthApi {
    @POST("auth/login")
    suspend fun login(@Body body: Map<String, String>): ApiResponse<TokenResponseDto>

    @POST("auth/register")
    suspend fun register(@Body body: Map<String, String>): ApiResponse<TokenResponseDto>

    @POST("auth/refresh")
    suspend fun refresh(@Body body: Map<String, String>): ApiResponse<TokenResponseDto>
}
