package com.caizhixng.githubapidemo.net

import com.caizhixng.githubapidemo.BuildConfig
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

/**
 * czx 2021/9/11
 */
object Net {

    private const val BASE_URL = "https://api.github.com/"
    private val client = OkHttpClient.Builder().apply {
        if (BuildConfig.DEBUG) {
            val log = HttpLoggingInterceptor()
            log.level = HttpLoggingInterceptor.Level.BODY
            addInterceptor(log)
        }
    }.build()

    private var retrofit: Retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL).addConverterFactory(GsonConverterFactory.create()).client(client).build()

    fun getService(): GithubApiServices {
        return retrofit.create(GithubApiServices::class.java)
    }

}