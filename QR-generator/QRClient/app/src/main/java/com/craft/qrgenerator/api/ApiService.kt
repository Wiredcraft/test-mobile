package com.craft.qrgenerator.api

import com.craft.qrgenerator.bean.SeedBean
import retrofit2.Call
import retrofit2.http.GET

interface ApiService {

    @GET("seed")
    fun getSeed(): Call<SeedBean>
}