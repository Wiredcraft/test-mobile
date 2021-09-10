package com.andzhv.githubusers.request.base

import io.reactivex.rxjava3.core.Observable

/**
 * Created by zhaowei on 2021/9/11.
 */
interface Request<T : Any> {

    fun readFromCache(): T? {
        return null
    }

    fun request(): Observable<T>
}