package com.andzhv.githubusers.request.search

import com.andzhv.githubusers.bean.BaseSearchResponse
import com.andzhv.githubusers.request.base.BaseListRequest
import com.andzhv.githubusers.utils.just
import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/11.
 */
abstract class BaseSearchListRequest<T : Any> : BaseListRequest<T, Int>() {

    private val perPage: Int = super.listLimit()

    /**
     * Whether the list is incomplete
     */
    private var incompleteResults: Boolean = false
    private var incompleteResultList = emptyList<T>()

    abstract fun searchRequest(page: Int, perPage: Int): Observable<BaseSearchResponse<T>>

    override fun action(): Observable<List<T>> {
        //todo If the data is incomplete
        return searchRequest(pageFlag ?: 1, perPage).flatMap {
            if (it.incompleteResults) {
                //If the data is incomplete, try to request once again
                searchRequest(pageFlag ?: 1, perPage).map { second ->
                    //Emitter the best result
                    if (!second.incompleteResults || second.items.size > it.items.size) {
                        second
                    } else {
                        it
                    }
                }
            } else {
                it.just()
            }
        }.doOnNext { incompleteResults = it.incompleteResults }.map {
            if (incompleteResults) {
                incompleteResultList = it.items
            }
            if (!incompleteResults && incompleteResultList.isNotEmpty()) {
                it.items.filterNot { item -> incompleteResultList.contains(item) }
            } else {
                it.items
            }
        }
    }

    override fun getPageFlag(list: List<T>): Int? {
        if (incompleteResults) {
            return pageFlag
        }
        val currentPage = pageFlag
        if (currentPage != null) {
            return currentPage + 1
        }
        return currentPage
    }

    override fun listLimit(): Int {
        return if (incompleteResults) incompleteResultList.size else super.listLimit()
    }

}