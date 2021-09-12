package com.andzhv.githubusers.ui.base

import com.andzhv.githubusers.request.base.BaseListRequest
import com.andzhv.githubusers.request.base.CatchErrorType
import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/11.
 */
abstract class BaseRequestListViewModel<M : Any>(
    var request: BaseListRequest<M>,
    hasLoadMore: Boolean = true
) : BaseListViewModel<M>(hasLoadMore) {

    init {
        // ViewModel needs to get the error
        if (request.error == CatchErrorType.CATCH) {
            request.error = CatchErrorType.NOT_CATCH
        } else if (request.error == CatchErrorType.CATCH_TOAST) {
            request.error = CatchErrorType.NOT_CATCH_SHOW
        }
    }

    override fun getCache(): List<M> {
        return request.readFromCache()
    }

    override fun getList(refresh: Boolean): Observable<List<M>> {
        if (refresh) request.refresh()
        return request.request()
    }

    override fun listLimit(): Int {
        return request.listLimit()
    }

}