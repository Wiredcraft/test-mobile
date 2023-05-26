package com.aric.repository

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
       ).build())
       .baseUrl("https://api.github.com")
       .addConverterFactory(GsonConverterFactory.create())
       .addCallAdapterFactory(CoroutineCallAdapterFactory())
       .build()

    fun getGithubApi(): GithubApi =retrofit.create(GithubApi::class.java)
}