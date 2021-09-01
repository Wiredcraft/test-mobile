package com.wiredcraft.demo.network

import com.wiredcraft.demo.base.BaseViewModel
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers

fun <T> Observable<T>.withLoading(
    loading: Boolean = true
): Observable<T> {
    return ObservableWithLoading(loading, this)
}

/**
 * can convert your response data from backend.
 */
inline fun <reified T, D : BaseResponse<T>> Observable<D>.businessConvert(): Observable<T> {
    return this.flatMap {
        when (it.incomplete) {
            true -> Observable.empty<T>()
            else -> Observable.just(it.items)
        }
    }
}

fun <T> Observable<T>.subscribeOnCreate(
    vm: BaseViewModel, onNext: ((T) -> Unit)? = null, onError: ((Throwable) -> Unit)? = null
) {
    vm.onCreateDisposables.add(doRealSubscribe(this, onNext, onError))
}

private fun <T> doRealSubscribe(
    o: Observable<T>, onNext: ((T) -> Unit)? = null, onError: ((Throwable) -> Unit)? = null
): Disposable {
    if (o is ObservableWithLoading) {
        return o.subscribeOn(Schedulers.io())
            .doOnSubscribe {
                // TODO:send msg to show loading.
            }
            .subscribeOn(AndroidSchedulers.mainThread())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                onNext?.invoke(it)
                // TODO:send msg to close loading.
            }, {
                onError?.invoke(it)
                // TODO:send msg to close loading.
            })
    }
    return o.subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe({ onNext?.invoke(it) }, { onError?.invoke(it) })
}

