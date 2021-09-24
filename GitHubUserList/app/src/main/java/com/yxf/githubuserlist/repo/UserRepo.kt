package com.yxf.githubuserlist.repo

import android.util.Log
import com.yxf.githubuserlist.api.GitHubService
import com.yxf.githubuserlist.model.bean.PageDetail
import com.yxf.mvvmcommon.mvvm.BaseRepository
import retrofit2.Retrofit

class UserRepo(private val service: GitHubService): BaseRepository() {

    suspend fun getUserList(page: Int): PageDetail {
        //API是从1开始的,代码中从0开始,所以这里加1


        val result = service.getUserListString(page + 1)
        Log.d("Debug", "result : $result")

        return service.getUserList(page + 1)
    }


}