package com.wiredcraft.network

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object RetrofitUtil {
    private lateinit var retrofit: Retrofit

    fun <T> create(service: Class<T>): T {
        return retrofit.create(service)
    }

    fun initialize() {
        retrofit = Retrofit.Builder()
            .baseUrl("https://api.github.com/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
    }
}