package com.seazon.qrgenerator.api

import com.seazon.qrgenerator.BaseApplication
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Created by seazon on 2018/3/8.
 */
class ApiManager {

    companion object {
        private var apiManager: ApiManager? = null
        fun getInstence(): ApiManager {
            if (apiManager == null) {
                synchronized(ApiManager::class.java) {
                    if (apiManager == null) {
                        apiManager = ApiManager()
                    }
                }
            }
            return apiManager!!
        }
    }

    private var apiService: ApiService? = null

    fun getApiService(): ApiService {
        // init okhttp
        val client = OkHttpClient.Builder()
                // add interceptor
                .addInterceptor(LogInterceptor())
                .build()
        if (apiService == null) {
            val retrofit = Retrofit.Builder()
                    .baseUrl(BaseApplication.HOST_URL)
                    // bind with okhtp
                    .client(client)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build()
            apiService = retrofit.create(ApiService::class.java)
        }
        return apiService!!
    }
}