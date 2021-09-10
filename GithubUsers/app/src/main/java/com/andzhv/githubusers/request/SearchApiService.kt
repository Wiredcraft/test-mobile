package com.andzhv.githubusers.request

import com.andzhv.githubusers.Config
import com.andzhv.githubusers.bean.BaseSearchResponse
import com.andzhv.githubusers.bean.SimpleUserBean
import io.reactivex.rxjava3.core.Observable
import retrofit2.http.GET
import retrofit2.http.Query

/**
 * Created by zhaowei on 2021/9/10.
 */
interface SearchApiService {
    @GET("users")
    fun getSimpleUserList(
        @Query("page") page: Int,
        @Query("q") keywords: String?,
        @Query("per_page") size: Int = Config.LIST_LIMIT
    ): Observable<BaseSearchResponse<List<SimpleUserBean>>>
}