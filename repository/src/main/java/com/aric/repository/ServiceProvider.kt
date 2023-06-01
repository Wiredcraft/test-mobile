package com.aric.repository

import android.webkit.WebSettings
import com.blankj.utilcode.util.Utils
import com.jakewharton.retrofit2.adapter.kotlin.coroutines.CoroutineCallAdapterFactory
import com.pluto.plugins.network.PlutoInterceptor
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

object ServiceProvider {

   private val retrofit: Retrofit = Retrofit.Builder()
       .client(OkHttpClient.Builder().callTimeout(5,TimeUnit.SECONDS).addInterceptor(
           PlutoInterceptor()
       ).addInterceptor {
           val request = it.request()
               .newBuilder()
               .removeHeader("User-Agent")//移除旧的
               .addHeader("User-Agent", WebSettings.getDefaultUserAgent(Utils.getApp()))//添加真正的头部
               .build()
           it.proceed(request)
       }
           .build())
       .baseUrl("https://api.github.com")
       .addConverterFactory(GsonConverterFactory.create())
       .addCallAdapterFactory(CoroutineCallAdapterFactory())
       .build()

    fun getGithubApi(): GithubApi =retrofit.create(GithubApi::class.java)
}
