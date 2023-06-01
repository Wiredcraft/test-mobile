package com.aric.repository

import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

/**
 * @author aric
 * @version 1.0.0
 *
 */
interface GithubApi {
    /**
     * Search github users by name
     */
    @GET("/search/users")
   suspend fun searchUserByName(@Query("q") q:String ="swift" ,@Query("page") page:String ="1" ): UserSearchResult

    /**
     * Get specific user's followers
     */
    @GET("/users/{user}/followers")
    suspend fun getAllFollowers(@Path("user") user:String ="swift"): List<UserInfo>

    /**
     * Get specific user's repos
     */
    @GET("/users/{user}/repos")
    suspend fun getAllRepos(@Path("user") user:String ="swift"):  List<RepoInfo>
}