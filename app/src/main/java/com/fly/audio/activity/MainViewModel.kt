package com.fly.audio.activity

import androidx.lifecycle.MutableLiveData
import com.fly.audio.api.UserApi
import com.fly.audio.ext.applyScheduler
import com.fly.audio.model.PageBean
import com.fly.audio.model.UserBean
import com.fly.core.base.BaseViewModel
import com.fly.core.network.RetrofitClient

/**
 * Created by likainian on 2021/8/31
 * Description:
 */

class MainViewModel : BaseViewModel() {
    private var apiServer= RetrofitClient.instance.create(UserApi::class.java)
    val userData = MutableLiveData<PageBean<UserBean>>()
    var page = 1

    /**
     * 请求下一页
     */
    fun requestNext(keyword: String){
        page += 1
        requestUser(keyword,page)
    }

    /**
     * 请求第一页
     */
    fun requestUser(keyword: String){
        page =1
        requestUser(keyword,page)
    }

    private fun requestUser(keyword: String,page:Int){
        addDisposable(
            apiServer.requestUser(keyword, page)
                .applyScheduler()
                .subscribe({
                           userData.postValue(it)
                },{ e->
                    e.printStackTrace()
                })
        )
    }
}