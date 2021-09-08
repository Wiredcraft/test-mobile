package com.fly.test.activity

import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.MutableLiveData
import com.fly.test.model.PageBean
import com.fly.test.model.UserBean
import com.fly.core.base.BaseViewModel
import com.fly.test.api.UserRepo

/**
 * Created by likainian on 2021/8/31
 * Description: 用户viewModel
 */
class MainViewModel @ViewModelInject constructor(private val userRepo: UserRepo) : BaseViewModel() {
    val userData = MutableLiveData<PageBean<UserBean>>()
    var page = 1

    /**
     * 请求下一页
     */
    fun requestNext(keyword: String) {
        page += 1
        requestUser(keyword, page)
    }

    /**
     * 请求第一页
     */
    fun requestUser(keyword: String) {
        page = 1
        requestUser(keyword, page)
    }

    private fun requestUser(keyword: String, page: Int) {
        addDisposable(
            userRepo.requestUser(keyword, page)
                .subscribe({
                    userData.postValue(it)
                }, { e ->
                    e.printStackTrace()
                })
        )
    }
}