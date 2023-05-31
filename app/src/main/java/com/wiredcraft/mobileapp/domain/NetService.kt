package com.wiredcraft.mobileapp.domain

import com.wiredcraft.mobileapp.net.Net
import com.wiredcraft.mobileapp.net.URL
import com.wiredcraft.mobileapp.domain.response.RepositoryListResponse
import com.wiredcraft.mobileapp.domain.response.UserListResponse
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: service class for retrofit
 *
 */
interface NetService {

    companion object {
        val SERVICE = Net.getService(NetService::class.java)
    }

    /**
     * query users
     */
    @GET(URL.PATH_USER_SEARCH)
    suspend fun queryUsers(@Query("q") queryWords: String, @Query("page") page: Int): UserListResponse


    /**
     * query user repositories
     */
    @GET(URL.PATH_USER_REPOSITORIES)
    suspend fun queryUserRepositories(@Path("user") user: String): ArrayList<RepositoryListResponse>?
}