package com.test.aric.data.remote

import com.test.aric.data.remote.dto.RepoInfo
import com.test.aric.data.remote.dto.UserInfo
import com.test.aric.data.remote.dto.UserSearchResult
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
   suspend fun searchUserByName(@Query("q") q:String  ,@Query("page") page:String): UserSearchResult

    /**
     * Get specific user's followers
     */
    @GET("/users/{user}/followers")
    suspend fun getAllFollowers(@Path("user") user:String ): List<UserInfo>

    /**
     * Get specific user's repos
     */
    @GET("/users/{user}/repos")
    suspend fun getAllRepos(@Path("user") user:String ):  List<RepoInfo>
}