package com.wiredcraft.example.viewmodel

import com.wiredcraft.example.net.request
import com.hp.marykay.viewmodel.BaseViewModel
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.LiveData
import androidx.lifecycle.LifecycleOwner
import com.wiredcraft.example.entity.Repo
import com.wiredcraft.example.entity.User
import com.wiredcraft.example.net.CObserver
import com.wiredcraft.example.net.HttpUserApi.getRepos

class UserDetailViewModel : BaseViewModel() {

    lateinit var user: User

    private val repoLiveData = MutableLiveData<List<Repo>?>()
    val _repos: LiveData<List<Repo>?>
        get() = repoLiveData

    fun getRepos(keyword: String, owner: LifecycleOwner) {
        getRepos(keyword).request(object : CObserver<List<Repo>>() {
            override fun onNext(data: List<Repo>) {
                repoLiveData.value = data
            }
        }, owner)
    }
}