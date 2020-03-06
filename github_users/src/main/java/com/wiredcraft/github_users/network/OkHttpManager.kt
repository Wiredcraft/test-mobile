package com.wiredcraft.testmoblie.network

import java.io.IOException
import java.util.concurrent.TimeUnit

import okhttp3.Call
import okhttp3.Callback
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.Response

/**
 * Okhttp网络请求工具类
 * @author Bruce
 * @date 2020/3/4.
 */

class OkHttpManager private constructor(){
    private var okHttpClient: OkHttpClient
    private var callBack: ResponseCallBack? = null

    init {
        okHttpClient = settings()
    }

    companion object {
        const val DEFAULT_TIMEOUT: Long = 60 //默认的超时时间,单位：秒

        val mInstance = OkHttpManagerHolder.holder
    }

    /**
     * 使用静态内部类的方式创建单例
     */
    private object OkHttpManagerHolder {
        val holder = OkHttpManager()
    }


    /**
     * 设置超时时间
     */
    private fun settings(): OkHttpClient {
        val builder = OkHttpClient.Builder()
        builder.connectTimeout(DEFAULT_TIMEOUT, TimeUnit.SECONDS)
        builder.readTimeout(DEFAULT_TIMEOUT, TimeUnit.SECONDS)
        builder.writeTimeout(DEFAULT_TIMEOUT, TimeUnit.SECONDS)
        return builder.build()
    }

    /**
     * get请求
     */
    fun doGet(url: String, callBack: ResponseCallBack) {
        this.callBack = callBack
        val request = Request.Builder()
                .url(url)
                .get()
                .build()
        enqueue(request)
    }

    /**
     * post请求
     */
    fun doPost(url: String, body: RequestBody, callBack: ResponseCallBack) {
        this.callBack = callBack

        val request = okhttp3.Request.Builder()
                .tag(url.hashCode())//通过访问url的hashcode打标签
                .url(url)
                .post(body)
                .build()

        enqueue(request)

    }

    /**
     * 异步请求方法
     */
    private fun enqueue(request: Request) {
        val call = okHttpClient.newCall(request)
        call.enqueue(object : Callback {

            override fun onFailure(call: Call, e: IOException) {
                callBack!!.onFailure(e)
            }

            @Throws(IOException::class)
            override fun onResponse(call: Call, response: Response) {
                callBack!!.onSuccess(response)
            }
        })

    }
}
