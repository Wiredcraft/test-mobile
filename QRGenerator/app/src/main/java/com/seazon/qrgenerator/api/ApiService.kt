package com.seazon.qrgenerator.api

import com.seazon.qrgenerator.entity.Seed
import retrofit2.Call
import retrofit2.http.GET

/**
 * Created by seazon on 2018/3/7.
 */
interface ApiService {

    @GET("seed")
    fun getSeed(): Call<Seed>

}