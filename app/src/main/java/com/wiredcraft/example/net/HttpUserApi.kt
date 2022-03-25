package com.wiredcraft.example.net

import com.hp.marykay.net.BaseApi
import com.wiredcraft.example.config.GlobalSettings
import com.wiredcraft.example.entity.Repo
import com.wiredcraft.example.entity.UserResponse
import io.reactivex.Observable
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory

object HttpUserApi : BaseApi() {
    private val service: HttpUserService by lazy(mode = LazyThreadSafetyMode.SYNCHRONIZED) {
        val retrofit = getRetrofitBuilder()
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .build()
        retrofit.create(HttpUserService::class.java)
    }

    fun getUsers(keyword: String,page:Int=1): Observable<UserResponse>{
        return service.getUsers(GlobalSettings.endpoint.queryUser.replace("\${keyword}", keyword, ignoreCase = true).replace("\${page}", page.toString(), ignoreCase = true))
    }

    fun getRepos(keyword: String): Observable<List<Repo>>{
        return service.getRepos(GlobalSettings.endpoint.getRepo.replace("\${keyword}", keyword, ignoreCase = true))
    }
}