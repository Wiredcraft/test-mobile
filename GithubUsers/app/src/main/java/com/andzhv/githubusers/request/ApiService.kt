package com.andzhv.githubusers.request

import com.andzhv.githubusers.BuildConfig
import com.google.gson.Gson
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Converter
import retrofit2.Retrofit
import retrofit2.adapter.rxjava3.RxJava3CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

/**
 * Created by zhaowei on 2021/9/11.
 */

val searchApiService by lazy {
    RetrofitBuilder().build("https://api.github.com/search/", SearchApiService::class.java)
}

class RetrofitBuilder {

    private lateinit var retrofit: Retrofit
    private var builder: OkHttpClient.Builder = OkHttpClient.Builder()

    init {
        with(builder) {
            connectTimeout(5, TimeUnit.SECONDS)
            readTimeout(5, TimeUnit.SECONDS)
            writeTimeout(5, TimeUnit.SECONDS)
            retryOnConnectionFailure(false)
        }
        if (BuildConfig.DEBUG) {
            val loggingInterceptor = HttpLoggingInterceptor()
            loggingInterceptor.level = HttpLoggingInterceptor.Level.BODY
            builder.addInterceptor(loggingInterceptor)
        }
    }

    fun <T> build(baseUrl: String, service: Class<T>): T {
        val build = Retrofit.Builder().baseUrl(baseUrl)
            .client(builder.build())
        converter().forEach { build.addConverterFactory(it) }
        build.addCallAdapterFactory(RxJava3CallAdapterFactory.create())
        retrofit = build.build()
        return retrofit.create(service)
    }


    private fun converter(): List<Converter.Factory> {
        return arrayListOf(GsonConverterFactory.create(Gson()))
    }
}