package com.hp.marykay.net.converter

import android.util.Log
import com.blankj.utilcode.BuildConfig
import com.hp.marykay.net.BaseApi
import com.hp.marykay.net.converter.RetrofitException.Companion.asRetrofitException
import io.reactivex.Completable
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.functions.Function
import retrofit2.Call
import retrofit2.CallAdapter
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import java.lang.reflect.Type

internal class RxErrorHandlingCallAdapterFactory private constructor() : CallAdapter.Factory() {
    private val original = RxJava2CallAdapterFactory.create()

    override fun get(returnType: Type, annotations: Array<Annotation>, retrofit: Retrofit): CallAdapter<*, *>? {
        return RxCallAdapterWrapper(original.get(returnType, annotations, retrofit) ?: return null)
    }

    private class RxCallAdapterWrapper<R>(private val wrapped: CallAdapter<R, *>) : CallAdapter<R, Any> {

        override fun responseType(): Type {
            return wrapped.responseType()
        }

        private fun debugThrowable(throwable: Throwable) {
            if (throwable.localizedMessage != null) {
                val msg = throwable.localizedMessage

                if (BuildConfig.DEBUG) {
                    Log.e(BaseApi.TAG, msg)
                }
            } else if (BuildConfig.DEBUG) {
                Log.e(BaseApi.TAG, "RxErrorDebug")
            }
        }

        override fun adapt(call: Call<R>): Any {
            return when (val result = wrapped.adapt(call)) {
                is Single<*> -> result.onErrorResumeNext(Function { throwable ->
                    debugThrowable(throwable)
                    Single.error(asRetrofitException(throwable))
                })
                is Observable<*> -> result.onErrorResumeNext(Function { throwable ->
                    debugThrowable(throwable)
                    Observable.error(asRetrofitException(throwable))
                })
                is Completable -> result.onErrorResumeNext(Function { throwable ->
                    debugThrowable(throwable)
                    Completable.error(asRetrofitException(throwable))
                })
                else -> result
            }

        }
    }

    companion object {
        fun create(): CallAdapter.Factory {
            return RxErrorHandlingCallAdapterFactory()
        }
    }
}