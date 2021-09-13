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
    private var currentListLimit = perPage

    init {
        error = CatchErrorType.CATCH_TOAST
    }

    abstract fun searchRequest(page: Int, perPage: Int): Observable<BaseSearchResponse<T>>

    override fun action(): Observable<List<T>> {
        return searchRequest((pageFlag as? Int) ?: 1, perPage).flatMap {
            // If there are continuous incomplete, return an error
            if (incompleteResults && it.incompleteResults) {
                Observable.error(Throwable(context.getString(R.string.network_error)))
            } else {
                it.just()
            }
        }.flatMap {
            if (it.incompleteResults && it.items.size < perPage) {
                //If the data is incomplete, try to request once again
                searchRequest((pageFlag as? Int) ?: 1, perPage).map { second ->
                    //Emitter the best result
                    if (!second.incompleteResults || second.items.size > it.items.size) second else it
                }.onErrorResumeWith(it.just())
            } else {
                it.just()
            }
        }.flatMap { response ->
            incompleteResults = response.incompleteResults && response.items.size < perPage
            //Remove duplicates bean
            if (incompleteResultList.isNotEmpty()) {
                response.items.filterNot { incompleteResultList.contains(it) }.just()
            } else {
                response.items.just()
            }
        }
    }

    override fun actionAndWriteCache(): Observable<List<T>> {
        return super.actionAndWriteCache().doOnNext {
            incompleteResultList = if (incompleteResults) it else emptyList()
            currentListLimit = if (incompleteResults) it.size else perPage
        }
    }

    override fun refresh() {
        pageFlag = 1
    }

    override fun isWriteCache(): Boolean {
        return pageFlag == 1
    }

    override fun getPageFlag(list: List<T>): Any? {
        // if the result is incomplete, pageFlag don't change
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
        return currentListLimit
    }

}