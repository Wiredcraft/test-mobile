package com.aric.finalweather

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.aric.finalweather.extentions.launch
import com.aric.repository.ServiceProvider
import com.aric.repository.UserInfo

class MainActivityViewModel : ViewModel() {

    private val _searchResult: MutableLiveData<List<UserInfo>> = MutableLiveData()
    val searchResult: LiveData<List<UserInfo>> = _searchResult


    fun searchUsersByName(name: String) {
        launch {
            _searchResult.value = ServiceProvider.getGithubApi().searchUserByName(name).items
        }
    }
}