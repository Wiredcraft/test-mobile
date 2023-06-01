package com.aric.finalweather

import android.text.Editable
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.aric.finalweather.extentions.launch
import com.aric.finalweather.extentions.notNull
import com.aric.repository.RepoInfo
import com.aric.repository.ServiceProvider
import com.aric.repository.UserInfo

class GithubViewModel : ViewModel() {

    private var page = 1

    private val _showLoading: MutableLiveData<Boolean> = MutableLiveData(false)
    val showLoading: LiveData<Boolean> = _showLoading

    private val _searchResult: MutableLiveData<List<UserInfo>> = MutableLiveData()
    val searchResult: LiveData<List<UserInfo>> = _searchResult

    private val _repoList: MutableLiveData<List<RepoInfo>> = MutableLiveData()
    val repoList: LiveData<List<RepoInfo>> = _repoList

    private val _input: MutableLiveData<String> = MutableLiveData("swift")
    val input: LiveData<String> = _input

    private val _selectedUser: MutableLiveData<UserInfo> = MutableLiveData()
    val selectedUser: LiveData<UserInfo> = _selectedUser

    fun onSearch() {
        _input.value.notNull {
            launch {
                _searchResult.value = ServiceProvider.getGithubApi().searchUserByName(it).items
            }
        }
    }

    fun getRepos() {
        launch {
            _selectedUser.value.notNull {
                _repoList.value = ServiceProvider.getGithubApi().getAllRepos(it.login)
            }
        }
    }

    fun updateSelectedUser(user: UserInfo) {
        _selectedUser.value = user
    }

    fun onChange(s: Editable) {
        _input.value = s.toString()
    }


    fun updateFollowingStatus(user: UserInfo = _selectedUser.value!!) {
        val  mutableList:MutableList<UserInfo> = mutableListOf()
        _searchResult.value.notNull { userInfoList ->
            userInfoList.forEach {
                if (it.id == user.id) {
                    val newItem =it.copy(follow = !it.follow)
                    mutableList.add(newItem)
                }else{
                    mutableList.add(it)
                }
            }
            _searchResult.value = mutableList
        }
    }

    fun updateSelectedFollowingStatus(user: UserInfo = _selectedUser.value!!) {
         updateFollowingStatus(user)
        _selectedUser.value = user.apply { follow = !follow }
    }

    fun loadMoreData() {
        page ++
        _input.value.notNull {
            launch {
                _searchResult.value = ServiceProvider.getGithubApi().searchUserByName(it, page.toString()).items  +  _searchResult.value!!
            }
        }
    }
}