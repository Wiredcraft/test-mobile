package com.yxf.githubuserlist.api

import com.yxf.githubuserlist.model.bean.PageDetail
import com.yxf.githubuserlist.model.bean.PageDetail2
import retrofit2.http.GET
import retrofit2.http.Query

interface GitHubService {

    @GET("search/users")
    suspend fun getUserList(@Query("page") page: Int, @Query("q") q: String = "swift"): PageDetail

    @GET("search/users")
    suspend fun getUserListString(@Query("page") page: Int, @Query("q") q: String = "swift"): PageDetail2

}