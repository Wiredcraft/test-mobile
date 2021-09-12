package com.andzhv.githubusers.request.base

import com.andzhv.githubusers.Config
import com.andzhv.githubusers.request.cache.Cache
import com.andzhv.githubusers.utils.ex.httpScheduler
import com.andzhv.githubusers.utils.ex.showFailedToast
import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/11.
 */
abstract class BaseListRequest<T : Any> : Request<List<T>> {

    /**
     * Paging request ID
     */
    protected var pageFlag: Any? = null

    /**
     * How to deal with errors
     * Catch: An error occurred, return Observable.empty()
     * Not Catch: Receiver processing error
     * Catch Toast: An error occurred, Show hint, return Observable.empty()
     */
    var error: CatchErrorType = CatchErrorType.CATCH

    /**
     * List cache
     */
    open var cache: Cache<T>? = null


    override fun readFromCache(): List<T> {
        return cache?.readList() ?: emptyList()
    }

    open fun refresh() {
        pageFlag = null
    }

    abstract fun action(): Observable<List<T>>


    override fun request(): Observable<List<T>> {
        return actionAndWriteCache().httpScheduler().compose {
            when (error) {
                CatchErrorType.CATCH -> it.onErrorResumeWith(Observable.empty())
                CatchErrorType.CATCH_TOAST -> {
                    it.doOnError { error ->
                        showFailedToast(error.message ?: error.localizedMessage ?: "Network error")
                    }.onErrorResumeWith(Observable.empty())
                }
                CatchErrorType.NOT_CATCH_SHOW -> {
                    it.doOnError { error ->
                        showFailedToast(error.message ?: error.localizedMessage ?: "Network error")
                    }
                }
                CatchErrorType.NOT_CATCH -> it
            }
        }
    }

    open fun actionAndWriteCache(): Observable<List<T>> {
        return action().doOnNext {
            if (pageFlag == null) {
                writeCache(it)
            }
            getPageFlag(it)?.run { pageFlag = this }
        }
    }

    abstract fun getPageFlag(list: List<T>): Any?

    open fun writeCache(list: List<T>) {
        cache?.write(list)
    }

    open fun listLimit(): Int {
        return Config.LIST_LIMIT
    }

}