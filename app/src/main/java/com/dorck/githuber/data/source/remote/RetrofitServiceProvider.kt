package com.dorck.githuber.data.source.remote

import com.dorck.githuber.utils.API_VERSION
import com.dorck.githuber.utils.BASE_URL
import com.google.gson.GsonBuilder
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Provide retrofit services for remote requests.
 * @author Dorck
 * @date 2023-06-09
 */
@Singleton
class RetrofitServiceProvider @Inject constructor() {
    private val okHttpBuilder: OkHttpClient.Builder = OkHttpClient.Builder()
    private val retrofit: Retrofit

    private var headerInterceptor = Interceptor { chain ->
        val original = chain.request()

        val request = original.newBuilder()
            .header("X-GitHub-Api-Version", API_VERSION)
            .method(original.method, original.body)
            .build()

        chain.proceed(request)
    }

    init {
        okHttpBuilder.addInterceptor(headerInterceptor)
//        okHttpBuilder.connectTimeout(timeoutConnect.toLong(), TimeUnit.SECONDS)
//        okHttpBuilder.readTimeout(timeoutRead.toLong(), TimeUnit.SECONDS)
        val client = okHttpBuilder.build()
        retrofit = Retrofit.Builder()
            .baseUrl(BASE_URL).client(client)
            .addConverterFactory(GsonConverterFactory.create(GsonBuilder().create()))
            .build()
    }

    fun <S> getService(serviceClass: Class<S>): S {
        return retrofit.create(serviceClass)
    }
}