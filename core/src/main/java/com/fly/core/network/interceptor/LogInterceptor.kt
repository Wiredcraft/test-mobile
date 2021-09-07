package com.fly.core.network.interceptor

import com.fly.core.util.LogUtil
import okhttp3.Interceptor
import okhttp3.Response
import okio.Buffer
import java.io.IOException

/**
 * Created by likainian on 2021/7/15
 * Description:请求日志打印
 */

class LogInterceptor : Interceptor {
    @Throws(IOException::class)
    override fun intercept(chain: Interceptor.Chain): Response? {
        val request = chain.request()
        //url
        val url = request.url()
        //request.headers
        val headers = request.headers()
        LogUtil.i(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
        LogUtil.i(url.toString() + " 请求方式:" + request.method())
        LogUtil.i("$url 请求header:$headers")
        //requestBody
        val requestBody = request.body()
        if (requestBody != null) {
            val buffer = Buffer()
            requestBody.writeTo(buffer)
            val paramsStr = buffer.readUtf8()
            LogUtil.i("$url 请求body:$paramsStr")
        } else {
            LogUtil.i("$url 请求body: {}")
        }
        //response
        val response = chain.proceed(request)
        if (response != null) {
            //response.headers
            val responseHeaders = response.headers()
            val url2 = response.request().url()
            LogUtil.i("$url2 返回header:$responseHeaders")
            //responseBody
            val responseBody = response.peekBody((1024 * 1024).toLong()).string()
            LogUtil.i("$url2 返回body:$responseBody")
        } else {
            LogUtil.i("$url 返回body is empty")
        }
        LogUtil.i("=======================================================")
        return response
    }
}