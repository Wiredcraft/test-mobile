package com.testmobile.githubuserslist.api

import retrofit2.http.GET
import retrofit2.http.Headers
import retrofit2.http.Query

/**
 * Retrofit api setup
*/
interface UsersApi {

    companion object {
        const val BASE_URL = "https://api.github.com/"
    }

    /**
    * returns [UserResponse]
    */
    @Headers("Accept: application/vnd.github.v3+json")
    @GET("search/users")
    suspend fun searchUsers(
        @Query("q") query: String,
        @Query("page") page: Int,
        @Query("per_page") pageSize: Int //number of items to return for each page
    ): UserResponse
}