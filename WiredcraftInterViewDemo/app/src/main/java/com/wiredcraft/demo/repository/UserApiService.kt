package com.wiredcraft.demo.repository

import com.wiredcraft.demo.network.BaseResponse
import com.wiredcraft.demo.repository.model.UserListDto
import io.reactivex.Observable
import retrofit2.http.GET
import retrofit2.http.Query

interface UserApiService {

    @GET("search/users")
    fun fetchUserList(
        @Query("page") page: Int,
        @Query("q") keywords: String?
    ): Observable<BaseResponse<List<UserListDto>>>
}