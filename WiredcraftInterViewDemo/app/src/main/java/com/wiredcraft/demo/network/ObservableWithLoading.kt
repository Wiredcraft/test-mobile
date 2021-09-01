package com.wiredcraft.demo.network

import io.reactivex.Observable
import io.reactivex.ObservableSource
import io.reactivex.Observer

/**
 * 用于网络请求的时候，显示loading框
 * [showLoading] 是否显示
 */
class ObservableWithLoading<T>(
    val showLoading: Boolean = true,
    private val source: ObservableSource<T>
) : Observable<T>() {

    override fun subscribeActual(observer: Observer<in T>) {
        source.subscribe(observer)
    }
}