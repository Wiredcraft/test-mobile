package com.example.testmobile

import com.example.testmobile.model.SearchUserResponse
import io.reactivex.Single
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface ApiService {

    @GET("/search/users")
    fun search(
        @Query("q") q: String,
        @Query("page") page: Int,
    ): Single<Response<SearchUserResponse>>

}