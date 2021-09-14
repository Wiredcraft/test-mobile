package com.example.testmobile

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.testmobile.model.GithubUser
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class HomeViewModel @Inject constructor(private val repository: ApiRepository) : ViewModel() {

    val users = MutableLiveData(mutableListOf<GithubUser>())
    private val currentPage = MutableLiveData(1)

    fun initHomePageData() {
        repository.searchUsers("swift", currentPage.value ?: 1) {
            val newList = mutableListOf<GithubUser>()
            newList.addAll(it.items ?: emptyList())
            users.value = newList
        }
    }
}