package com.andzhv.githubusers.utils.ex

import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.schedulers.Schedulers

/**
 * Created by zhaowei on 2021/9/10.
 */
fun <T : Any> Observable<T>.httpScheduler(): Observable<T> {
    return compose { it.subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread()) }
}

fun <T: Any> T.just(): Observable<T> {
    return Observable.just(this)
}