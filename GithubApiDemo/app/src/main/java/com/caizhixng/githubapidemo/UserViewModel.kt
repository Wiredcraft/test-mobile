package com.caizhixng.githubapidemo

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

/**
 * czx 2021/9/11
 */
class UserViewModel : ViewModel() {

    private val _userListResponse = MutableStateFlow(Resource.success(emptyList<MockUser>()))
    val userListResponse: StateFlow<Resource<List<MockUser>>> = _userListResponse

    fun searchUsers() {
        viewModelScope.launch(Dispatchers.IO) {
            _userListResponse.value = Resource.loading(emptyList())
            delay(1000)
            val mockUserList = arrayListOf<MockUser>()
            repeat(50) {
                mockUserList.add(MockUser("lee", it.toString(), "www.baidu.com"))
            }
            _userListResponse.value = Resource.success(mockUserList)
        }
    }

}