package com.seazon.qrgenerator.api

import android.util.Log
import okhttp3.Interceptor
import okhttp3.Response
import java.nio.charset.Charset

/**
 * Created by seazon on 2018/3/8.
 */
class LogInterceptor : Interceptor {

    private val TAG = LogInterceptor::class.java.simpleName

    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request()

        // log url and body
        Log.d(TAG, ">>>> " + request.url().toString())

        val response = chain.proceed(request)

        // log code and response
        Log.d(TAG, "<<<< " + "code: " + response.code())
        val responseBody = response.body()
        val source = responseBody.source()
        source.request(java.lang.Long.MAX_VALUE) // Buffer the entire body.
        val buffer = source.buffer()
        Log.d(TAG, "<<<< " + buffer.clone().readString(Charset.forName("UTF-8")))

        return response
    }
}