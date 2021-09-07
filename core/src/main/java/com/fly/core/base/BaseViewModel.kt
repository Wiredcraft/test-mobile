package com.fly.core.base

import androidx.lifecycle.ViewModel
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.disposables.Disposable

/**
 * Created by likainian on 2021/7/13
 * MVVM BaseViewModel (ViewModel don't hold View, store and manage UI-related data)
 */
abstract class BaseViewModel : ViewModel() {

    private val composite = CompositeDisposable()

    protected fun addDisposable(d: Disposable?) {
        if (d == null) return
        composite.add(d)
    }

    override fun onCleared() {
        super.onCleared()
        composite.dispose()
    }

}