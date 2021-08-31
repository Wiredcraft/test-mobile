package com.fly.audio.api

import com.fly.audio.model.PageBean
import com.fly.audio.model.UserBean
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