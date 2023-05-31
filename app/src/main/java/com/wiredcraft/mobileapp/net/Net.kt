package com.wiredcraft.mobileapp.net

import com.wiredcraft.mobileapp.BuildConfig
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: simple http requester
 *
 */
object Net {

    private lateinit var okHttpClient: OkHttpClient

    init {
        val builder = OkHttpClient.Builder()
            .connectTimeout(5, TimeUnit.SECONDS)

        if (BuildConfig.ENABLED_HTTP_LOGCAT) {
            builder.addInterceptor(HttpLoggingInterceptor().apply {
                level = HttpLoggingInterceptor.Level.BODY
            })
        }

        builder.build()
    }

    val retrofit = Retrofit.Builder()
        .baseUrl(URL.BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .client(okHttpClient)
        .build()


    fun <T> getService(clazz: Class<T>): T {
        return retrofit.create(clazz)
    }
}