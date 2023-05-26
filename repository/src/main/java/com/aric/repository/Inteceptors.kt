package com.aric.repository

import android.util.Log
import okhttp3.Interceptor
import okhttp3.Response
import okio.IOException

class ErrorHandlingInterceptor : Interceptor {
    @Throws(IOException::class)
    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request()
        val response = chain.proceed(request)
        Log.d("Aric", "intercept: ${response.code}")
        throw NotFoundException()
        return response
    }
}