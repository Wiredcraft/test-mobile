package com.lwjlol.github.user

import android.annotation.SuppressLint
import android.util.Log
import com.lwjlol.github.user.model.User
import com.lwjlol.github.user.model.UserResponse
import com.squareup.moshi.Moshi
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import retrofit2.http.GET
import retrofit2.http.Query
import java.security.cert.X509Certificate
import javax.net.ssl.SSLContext
import javax.net.ssl.TrustManager
import javax.net.ssl.X509TrustManager

val retrofit by lazy {
    Retrofit.Builder()
        .client(OkHttpClient.Builder().apply {
            trustAllCertification()
            addInterceptor(
                HttpLoggingInterceptor { message ->
                    Log.d(
                        "okhttp", String(message.toByteArray())
                    )
                }.apply {
                    setLevel(HttpLoggingInterceptor.Level.BODY)
                })
        }.build())
        .baseUrl("https://api.github.com/")
        .addConverterFactory(
            MoshiConverterFactory.create(
                Moshi.Builder()
                    .build()
            )
        )
        .build()
}

class UserRepository(retrofit: Retrofit) {
    private val service by lazy {
        retrofit.create(UserService::class.java)
    }

    /**
     * @return 0:totalCount
     *         1:items
     */
    suspend fun getUsers(q: String, page: Int): Pair<Int, List<User>> {
        try {
            service.searchUser(q = q, page = page).let {
                return it.totalCount to it.items
            }
        } catch (e: Exception) {
            return 0 to emptyList()
        }
    }
}

interface UserService {
    @GET("search/users")
    suspend fun searchUser(@Query("q") q: String, @Query("page") page: Int): UserResponse
}


fun OkHttpClient.Builder.trustAllCertification(): OkHttpClient.Builder {
    val trustAllCerts = arrayOf<TrustManager>(object : X509TrustManager {
        @SuppressLint("TrustAllX509TrustManager")
        override fun checkClientTrusted(
            chain: Array<out X509Certificate>?,
            authType: String?
        ) {

        }

        @SuppressLint("TrustAllX509TrustManager")
        override fun checkServerTrusted(
            chain: Array<out X509Certificate>?,
            authType: String?
        ) {
        }

        override fun getAcceptedIssuers(): Array<X509Certificate> {
            return emptyArray()
        }
    })

    // Install the all-trusting trust manager
    val sslContext = SSLContext.getInstance("SSL")
    sslContext.init(null, trustAllCerts, java.security.SecureRandom())
    // Create an ssl socket factory with our all-trusting manager
    val sslSocketFactory = sslContext.socketFactory
    sslSocketFactory(sslSocketFactory, trustAllCerts[0] as X509TrustManager)
    return this
}