package com.caizhixng.githubapidemo.net

import retrofit2.http.GET
import retrofit2.http.Query

/**
 * czx 2021/9/11
 */
interface GithubApiServices {

    /**
     * https://docs.github.com/en/rest/reference/search#search-users
     * */
    @GET("search/users")
    suspend fun searchUsers(
        @Query("per_page") perPage: Int,
        @Query("page") page: Int,
        @Query("q") keyWord: String
    ): UserWrapper
}