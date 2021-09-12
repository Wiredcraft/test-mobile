package com.andzhv.githubusers.request.search

import com.andzhv.githubusers.GithubApplication.Companion.context
import com.andzhv.githubusers.R
import com.andzhv.githubusers.bean.BaseSearchResponse
import com.andzhv.githubusers.request.base.BaseListRequest
import com.andzhv.githubusers.request.base.CatchErrorType
import com.andzhv.githubusers.utils.ex.just
import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/11.
 */
abstract class BaseSearchListRequest<T : Any> : BaseListRequest<T>() {

    private val perPage: Int = super.listLimit()

    /**
     * Whether the list is incomplete
     */
    private var incompleteResults: Boolean = false
    private var incompleteResultList = emptyList<T>()
    private var currentResultSize = perPage

    init {
        error = CatchErrorType.CATCH_TOAST
    }

    abstract fun searchRequest(page: Int, perPage: Int): Observable<BaseSearchResponse<T>>

    override fun action(): Observable<List<T>> {
        return searchRequest((pageFlag as? Int) ?: 1, perPage).flatMap {
            if (it.incompleteResults) {
                //If the data is incomplete, try to request once again
                searchRequest((pageFlag as? Int) ?: 1, perPage).map { second ->
                    //Emitter the best result
                    if (!second.incompleteResults || second.items.size > it.items.size) second else it
                }
            } else {
                it.just()
            }
        }.flatMap { response ->
            if (incompleteResults && response.incompleteResults) {
                // If there are continuous incomplete, return an error
                Observable.error(Throwable(context.getString(R.string.network_error)))
            } else {
                incompleteResults = response.incompleteResults
                //Remove duplicates bean
                if (incompleteResultList.isNotEmpty()) {
                    response.items.filterNot { incompleteResultList.contains(it) }.just()
                } else {
                    response.items.just()
                }
            }
        }
    }

    override fun actionAndWriteCache(): Observable<List<T>> {
        return super.actionAndWriteCache().doOnNext {
            incompleteResultList = if (incompleteResults) it else emptyList()
            currentResultSize = it.size
        }
    }

    override fun refresh() {
        pageFlag = 1
    }

    override fun isWriteCache(): Boolean {
        return pageFlag == 1
    }

    override fun getPageFlag(list: List<T>): Any? {
        if (incompleteResults) {
            return pageFlag
        }
        val currentPage = pageFlag
        if (currentPage != null && currentPage is Int) {
            return currentPage + 1
        }
        return currentPage
    }

    override fun listLimit(): Int {
        return currentResultSize
    }

}