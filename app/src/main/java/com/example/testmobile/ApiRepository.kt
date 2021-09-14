package com.example.testmobile

import com.example.testmobile.model.SearchUserResponse
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Response
import javax.inject.Inject

class ApiRepository @Inject constructor(private val apiService: ApiService) {

    interface ApiCallback<T> {
        fun onSuccess(response: T)

        fun onError(t: Throwable?)
    }

    private fun <T> requestApi(
        observable: Single<Response<T>>,
        successCallback: (res: T) -> Unit,
        failureCallback: (t: Throwable?) -> Unit
    ) {
        val subscribe = observable.subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe { t1, t2 ->
                val body = t1.body()
                if (t1?.code() == 200) {
                    body?.let {
                        successCallback.invoke(it)
                    }
                } else {
                    failureCallback.invoke(t2)
                }
            }
    }

    fun searchUsers(q: String, page: Int, apiCallback: ApiCallback<SearchUserResponse>) {
        requestApi(apiService.search(q, page), {
            apiCallback.onSuccess(it)
        }, {
            apiCallback.onError(it)
        })
    }

}