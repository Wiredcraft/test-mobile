package com.dorck.githuber.data.source.remote.service

import com.dorck.githuber.data.entities.GithubRepo
import com.dorck.githuber.data.entities.UsersSearchResult
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

/**
 * REST API service of Github.
 * @author Dorck
 * @date 2023-06-08
 */
interface GithubService {
    /**
     * Fetch search result of users.
     * Api doc: https://docs.github.com/zh/rest/search?apiVersion=2022-11-28#search-users
     * @param keyword The username.
     * @param page Current data page index.
     * @param perPage Data limit count of one page. Default value is 30.
     */
    @GET("/search/users")
    suspend fun searchUsers(
        @Query("q") keyword: String,
        @Query("page") page: Int,
        @Query("per_page") perPage: Int
    ): Response<UsersSearchResult>

    /**
     * Fetch repo list from a specific user.
     * Api doc: https://docs.github.com/zh/rest/repos/repos?apiVersion=2022-11-28#list-repositories-for-a-user
     * @param username The user login name.
     * @param page Current data page index.
     * @param perPage Data limit count of one page. Default value is 30.
     */
    @GET("/users/{username}/repos")
    suspend fun getUserRepoList(
        @Path("username") username: String,
        @Query("page") page: Int,
        @Query("per_page") perPage: Int
    ): Response<List<GithubRepo>>
}