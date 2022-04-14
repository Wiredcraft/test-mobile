package com.wiredcraft.githubuser.network

import com.wiredcraft.githubuser.data.model.GitHubUsers
import com.wiredcraft.githubuser.data.model.UserRepos
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface GitHubService {
    @GET("search/users")
    fun getGitHubUsers(@Query("q") q: String, @Query("page") page: Int): Call<GitHubUsers>

    @GET("users/swift/repos")
    fun getUserRepos(): Call<ArrayList<UserRepos>>
}