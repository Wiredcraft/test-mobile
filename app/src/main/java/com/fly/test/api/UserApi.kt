package com.fly.test.api

import com.fly.test.model.PageBean
import com.fly.test.model.UserBean
import io.reactivex.Observable
import retrofit2.http.*

/**
 * Created by likainian on 2021/7/15
 * Description: userapi
 */

interface UserApi {
    @GET("search/users")
    fun requestUser(@Query("q") keyword:String,@Query("page") page:Int): Observable<PageBean<UserBean>>
}