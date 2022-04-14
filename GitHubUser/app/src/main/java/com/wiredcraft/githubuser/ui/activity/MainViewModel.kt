package com.wiredcraft.githubuser.ui.activity

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Transformations
import androidx.lifecycle.ViewModel
import com.wiredcraft.githubuser.data.Repository

class MainViewModel : ViewModel() {

    private val _userMapLiveData = MutableLiveData<Map<String, String>>()

    fun getGitHubUsers(q: String, page: Int) {
        _userMapLiveData.value = mapOf("q" to q, "page" to page.toString())
    }

    val userList = Transformations.switchMap(_userMapLiveData) {
        Repository.searchUsers(it["q"]!!, it["page"]!!.toInt())
    }
}