package com.wiredcraft.viewmodel

import androidx.lifecycle.ViewModel
import com.wiredcraft.bean.SearchUser

class SearchUserViewModel : ViewModel() {
    var isFirst = true
    var scrollY = 0
    var page = 1
    var searchUser = SearchUser()
    val defKeyword = "Swift"
    var query = ""

    override fun onCleared() {
        searchUser.items.clear()
    }
}