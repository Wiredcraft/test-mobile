package com.yxf.mvvmcommon.http.interceptor

import android.util.Log
import okhttp3.Interceptor
import okhttp3.Response
import java.io.IOException

class RetryInterceptor(private val maxTryCount: Int = 3) : Interceptor {

    private val TAG = RetryInterceptor::class.qualifiedName

    @Throws(IOException::class)
    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request()
        var response: Response? = null
        var count = 0
        while (count < maxTryCount) {
            try {
                response = chain.proceed(request)
                if (response.isSuccessful) {
                    break
                } else {
                    count++
                }
            } catch (e: Exception) {
                count++
                if (count < maxTryCount) {
                    Log.d(TAG, "get response failed, has try $count times", e)
                } else {
                    throw e
                }

            }
        }

        return response!!
    }
}