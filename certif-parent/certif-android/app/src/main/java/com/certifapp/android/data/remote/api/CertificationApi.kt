// certif-parent/certif-android/app/src/main/java/com/certifapp/android/data/remote/api/CertificationApi.kt
package com.certifapp.android.data.remote.api

import com.certifapp.android.data.remote.dto.ApiResponse
import com.certifapp.android.data.remote.dto.CertificationDto
import retrofit2.http.GET
import retrofit2.http.Path

/** Retrofit interface for certification endpoints. */
interface CertificationApi {
    @GET("certifications")
    suspend fun getAll(): ApiResponse<List<CertificationDto>>

    @GET("certifications/{id}")
    suspend fun getById(@Path("id") id: String): ApiResponse<CertificationDto>
}
