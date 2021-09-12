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

    companion object {
        const val KEYWORD = "Android"
    }

    override var cache: Cache<SimpleUserBean>? = SimpleUserCache.DefaultList()

    private val userIdSet = mutableSetOf<Long>()

    override fun searchRequest(
        page: Int,
        perPage: Int
    ): Observable<BaseSearchResponse<SimpleUserBean>> {
        return searchApiService.getSimpleUserList(
            page,
            if (keywoard.isEmpty()) KEYWORD else keywoard,
            perPage
        )
    }

    /**
     * When the list is refreshing
     */
    override fun refresh() {
        super.refresh()
        userIdSet.clear()
    }

    override fun action(): Observable<List<SimpleUserBean>> {
        return super.action().map { list ->
            //The data returned by the server may be duplicated
            list.filter {
                val result = userIdSet.contains(it.id)
                if (!result) userIdSet.add(it.id)
                !result
            }
        }
    }

    override fun isWriteCache(): Boolean {
        return super.isWriteCache() && keywoard.isEmpty()
    }
}