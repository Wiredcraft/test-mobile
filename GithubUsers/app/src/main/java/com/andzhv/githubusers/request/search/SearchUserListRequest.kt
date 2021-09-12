package com.andzhv.githubusers.request.search

import com.andzhv.githubusers.bean.BaseSearchResponse
import com.andzhv.githubusers.bean.SimpleUserBean
import com.andzhv.githubusers.request.cache.Cache
import com.andzhv.githubusers.request.cache.SimpleUserCache
import com.andzhv.githubusers.request.searchApiService
import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/11.
 */
class SearchUserListRequest(var keywoard: String) : BaseSearchListRequest<SimpleUserBean>() {

//    override var cache: Cache<SimpleUserBean>? = SimpleUserCache.DefaultList()

    override fun searchRequest(
        page: Int,
        perPage: Int
    ): Observable<BaseSearchResponse<SimpleUserBean>> {
        return searchApiService.getSimpleUserList(page, keywoard, perPage)
    }
}