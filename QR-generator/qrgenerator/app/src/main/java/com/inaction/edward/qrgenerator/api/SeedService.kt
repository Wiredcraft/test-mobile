package com.inaction.edward.qrgenerator.api

import com.inaction.edward.qrgenerator.entities.Seed
import retrofit2.Call
import retrofit2.http.GET

interface SeedService {

    @GET("/api/seed")
    fun generateSeed(): Call<Seed>

}


