package com.dorck.githuber.ui.pages.home

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.dorck.githuber.data.GithubDataRepository
import com.dorck.githuber.data.entities.UsersSearchResult
import com.dorck.githuber.data.source.common.Result
import com.dorck.githuber.ui.wrapper.UserDisplayBean
import com.dorck.githuber.ui.wrapper.UserDisplayUIState
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

/**
 * View model layer for github user list of homepage.
 * @author Dorck
 */
@HiltViewModel
class HomeUsersViewModel @Inject constructor(private val dataRepository: GithubDataRepository) :
    ViewModel() {

    private val _uiState: MutableStateFlow<UserDisplayUIState> =
        MutableStateFlow(UserDisplayUIState())
    val uiState: StateFlow<UserDisplayUIState> = _uiState.asStateFlow()

    private var pageIndex = 1

    // User source data collection.
    private var _userList = mutableListOf<UserDisplayBean>()

    init {
        // Need to fetch default users at first launch.
        fetchUsers()
    }

    /**
     * Search for github users with [username].
     */
    fun fetchUsers(username: String = "android", perPage: Int = 30, isPullRefresh: Boolean = false) {
        viewModelScope.launch {
            dataRepository.searchUsers(username, pageIndex, perPage).collect { result ->
                when (result) {
                    is Result.Success -> {
                        Log.d(TAG, "fetchUsers: succeed >> $result")
                        result.data?.let {
                            pageIndex++
                            _uiState.value =
                                UserDisplayUIState(convertAndAppendUserDisplayList(result.data))
                        }
                    }
                    is Result.Loading -> _uiState.value =
                        UserDisplayUIState(isLoading = true, isRefreshing = isPullRefresh)
                    is Result.Error -> {
                        Log.w(TAG, "fetchUsers: failure => $result")
                        _uiState.value = UserDisplayUIState(errorMessage = convertUIError(result))
                    }
                }
            }
        }
    }

    fun refreshUserSearching(name: String, isPullRefresh: Boolean = false) {
        pageIndex = 1
        _userList.clear()
        fetchUsers(name, isPullRefresh = isPullRefresh)
    }

    fun followUser(userId: String) {
        viewModelScope.launch {
            dataRepository.follow(userId).collect {
                if (it is Result.Success) {
                    handleFollowStatus(userId)
                }
            }
        }
    }

    private fun handleFollowStatus(userId: String) {
        val newData = mutableListOf<UserDisplayBean>()
        _userList.forEach { oldUser ->
            if (oldUser.id == userId) {
                newData.add(oldUser.copy(following = !oldUser.following))
            } else {
                newData.add(oldUser)
            }
        }
        _userList = newData
        _uiState.value = UserDisplayUIState(userList = newData)
    }

    private fun convertUIError(errorData: Result.Error<UsersSearchResult>): String {
        return when (errorData.errCode) {
            400 -> "Bad Request or api version is not supported."
            403, 404 -> "Authentication failed or resource cannot be found."
            422 -> "Unprocessable Entity."
            // More troubleshot reference: https://docs.github.com/en/rest/overview/troubleshooting
            else -> errorData.msg ?: "Unknown error."
        }
    }

    private fun convertAndAppendUserDisplayList(userResult: UsersSearchResult): List<UserDisplayBean> {
        return _userList.apply {
            plusAssign(userResult.items.map {
                UserDisplayBean.from(it)
            }.toMutableList())
        }
    }
}