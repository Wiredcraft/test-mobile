package com.wiredcraft.example.viewmodel

import com.wiredcraft.example.net.HttpUserApi.getUsers
import com.wiredcraft.example.net.request
import com.hp.marykay.viewmodel.BaseViewModel
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.LiveData
import androidx.lifecycle.LifecycleOwner
import com.wiredcraft.example.entity.User
import com.wiredcraft.example.entity.UserResponse
import com.wiredcraft.example.net.CObserver

class MainViewModel : BaseViewModel() {
    private val userLiveData = MutableLiveData<MutableList<User>?>()
    val _user: LiveData<MutableList<User>?>
        get() = userLiveData

    private var page = 1

    fun getUsers(keyword: String, refresh: Boolean, owner: LifecycleOwner) {
        if (refresh) {
            page = 1
        } else {
            page++
        }

        getUsers(keyword, page).request(object : CObserver<UserResponse>() {
            override fun onNext(userResponse: UserResponse) {
                userLiveData.setValue(userResponse.items)
            }
        }, owner)
    }
}