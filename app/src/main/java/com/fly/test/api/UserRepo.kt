package com.fly.test.api

import com.fly.test.ext.applyScheduler
import com.fly.test.model.PageBean
import com.fly.test.model.UserBean
import io.reactivex.Observable
import javax.inject.Inject

class UserRepo @Inject constructor(
    private val userApi: UserApi
) {

    fun requestUser(keyword: String,page:Int): Observable<PageBean<UserBean>> {
        return userApi.requestUser(keyword, page)
            .applyScheduler()
    }
}