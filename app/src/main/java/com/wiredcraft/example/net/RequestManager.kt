package com.wiredcraft.example.net

import android.util.Log
import androidx.lifecycle.LifecycleOwner
import com.hp.marykay.net.BaseApi
import com.uber.autodispose.AutoDispose
import com.uber.autodispose.android.lifecycle.AndroidLifecycleScopeProvider
import com.wiredcraft.example.BuildConfig
import io.reactivex.Observable
import io.reactivex.Observer
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.Disposable
import io.reactivex.schedulers.Schedulers

fun <T> Observable<T>.request(observer: Observer<T>, owner: LifecycleOwner) {
    this.subscribeOn(Schedulers.io()).observeOn(AndroidSchedulers.mainThread())
        .`as`(AutoDispose.autoDisposable<T>(AndroidLifecycleScopeProvider.from(owner))).subscribe(observer)
}

abstract class CObserver<T> : Observer<T> {
    override fun onComplete() {

    }

    override fun onSubscribe(d: Disposable) {
    }


    override fun onError(e: Throwable) {
        Log.d(BaseApi.TAG,"CObserver发生错误: ${e.localizedMessage ?: e.message}")

        if (BuildConfig.DEBUG) {
            e.printStackTrace()
        }
    }

}
