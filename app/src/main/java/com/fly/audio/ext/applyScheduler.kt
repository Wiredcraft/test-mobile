package com.fly.audio.ext

import io.reactivex.Observable
import io.reactivex.ObservableSource
import io.reactivex.ObservableTransformer
import io.reactivex.Scheduler
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers

/**
 * Created by likainian on 2021/7/13
 * Description:  指定rxjava的线程
 */

fun <T> Observable<T>.applyScheduler(subscribeOn: Scheduler = Schedulers.io()): Observable<T> {
    return compose(SchedulerTransformer.apply(subscribeOn))
}

internal class SchedulerTransformer<T> private constructor(private var subscribeOnScheduler: Scheduler?) :
    ObservableTransformer<T, T> {

    override fun apply(upstream: Observable<T>): ObservableSource<T> {
        return upstream.subscribeOn(subscribeOnScheduler)
            .unsubscribeOn(subscribeOnScheduler)
            .observeOn(AndroidSchedulers.mainThread())
    }

    companion object {

        @JvmStatic
        fun <T> apply(subscribeOn: Scheduler): SchedulerTransformer<T> {
            return SchedulerTransformer(subscribeOn)
        }
    }
}