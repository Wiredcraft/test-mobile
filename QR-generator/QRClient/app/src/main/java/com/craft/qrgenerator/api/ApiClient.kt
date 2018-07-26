package com.craft.qrgenerator.api

import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit


class ApiClient {

    private var apiService: ApiService? = null

    companion object {
        //api
        const val API_URL = "http://192.168.100.212:3600"

        private var apiClient: ApiClient? = null
            get() {
                if (field == null) {
                    field = ApiClient()
                }
                return field
            }

        @Synchronized
        fun get(): ApiClient {
            return apiClient!!
        }
    }


    fun getApiService(): ApiService {
        // init okhttp
        val client = OkHttpClient.Builder()
                .retryOnConnectionFailure(true)
                .connectTimeout(15, TimeUnit.SECONDS)
                .build()

        if (apiService == null) {
            val retrofit = Retrofit.Builder()
                    .baseUrl(API_URL)
                    .client(client)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build()
            apiService = retrofit.create(ApiService::class.java)
        }
        return apiService!!
    }


}