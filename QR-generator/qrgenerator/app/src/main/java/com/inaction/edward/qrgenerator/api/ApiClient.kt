package com.inaction.edward.qrgenerator.api

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object ApiClient {

    private val mRetrofitClient: Retrofit

    private val mSeedService: SeedService

    init {
        mRetrofitClient = Retrofit.Builder()
                .baseUrl(SERVER_BASE_URL)
                .addConverterFactory(GsonConverterFactory.create())
                .build()

        mSeedService = mRetrofitClient.create(SeedService::class.java)
    }

    fun getSeedService(): SeedService {
        return mSeedService
    }
}
