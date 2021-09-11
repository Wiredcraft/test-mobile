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

    val page = Page(keyWord = SharedPreferencesManager.keyWord, page = 1, perPage = 30)

    private val _userListResponse = MutableStateFlow(Resource.success(emptyList<User>()))
    val userListResponse: StateFlow<Resource<List<User>>> = _userListResponse

    fun searchUsers() {
        viewModelScope.launch(Dispatchers.IO) {
            _userListResponse.value = Resource.loading(emptyList())
            try {
                val res =
                    Net.getService().searchUsers(
                        perPage = page.perPage,
                        page = page.page,
                        keyWord = page.keyWord
                    )
                // update keyWord for next enter the app show search
                // maybe can save net data to local database
                SharedPreferencesManager.keyWord = page.keyWord
                _userListResponse.value = Resource.success(res.userList)
            } catch (e: Exception) {
                _userListResponse.value =
                    Resource.error("error ${e.printStackTrace()}", emptyList())
            }
        }
    }

}