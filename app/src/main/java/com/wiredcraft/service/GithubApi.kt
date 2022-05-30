package com.wiredcraft.service

import com.wiredcraft.bean.SearchUser
import com.wiredcraft.bean.UserReposInfo
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface GithubApi {
    @GET("/search/users")
    suspend fun searchUser(
        @Query("q") query: String = "swift",
        @Query("page") page: Int = 1
    ): SearchUser

    @GET("/users/{userName}/repos")
    suspend fun userRepos(@Path("userName") userName: String): ArrayList<UserReposInfo>
}