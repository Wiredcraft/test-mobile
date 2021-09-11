package com.caizhixng.githubapidemo

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

/**
 * czx 2021/9/11
 */
class UserViewModel : ViewModel() {

    private val _userListResponse = MutableStateFlow(Resource.success(emptyList<User>()))
    val userListResponse: StateFlow<Resource<List<User>>> = _userListResponse

    fun searchUsers() {
        viewModelScope.launch(Dispatchers.IO) {
            _userListResponse.value = Resource.loading(emptyList())
            try {
                val res =
                    Net.getService().searchUsers(perPage = 30, page = 1, keyWord = "caizhixing")
                if (res.totalCount > 0) {
                    _userListResponse.value = Resource.success(res.userList)
                } else {
                    _userListResponse.value = Resource.error("query is Empty", res.userList)
                }
            } catch (e: Exception) {
                _userListResponse.value =
                    Resource.error("error ${e.printStackTrace()}", emptyList())
            }
        }
    }

}