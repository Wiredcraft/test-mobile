package com.example.testmobile

import com.example.testmobile.model.SearchUserResponse
import io.reactivex.Single
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.Response
import javax.inject.Inject

class ApiRepository @Inject constructor(private val apiService: ApiService) {

    private fun <T> requestApi(
        observable: Single<Response<T>>,
        callback: (t: T) -> Unit
    ) {
        val subscribe = observable.subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe { t1, t2 ->
                val body = t1.body()
                if (t1?.code() == 200) {
                    body?.let {
                        callback.invoke(it)
                    }
                }
            }
    }

    fun searchUsers(q: String, page: Int, callback: (response: SearchUserResponse) -> Unit) {
        requestApi(apiService.search(q, page)) {
            callback.invoke(it)
        }
    }

}