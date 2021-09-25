package com.yxf.githubuserlist.api

import com.yxf.githubuserlist.model.bean.PageDetail
import retrofit2.http.GET
import retrofit2.http.Query

interface GitHubService {

    @GET("search/users")
    suspend fun getUserList(@Query("page") page: Int, @Query("q") q: String = "swift"): PageDetail

}