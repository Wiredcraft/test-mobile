package com.dorck.githuber.ui.pages.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.dorck.githuber.data.GithubDataRepository
import com.dorck.githuber.data.entities.UsersSearchResult
import com.dorck.githuber.data.source.common.Result
import com.dorck.githuber.data.source.common.extractUIError
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
//    private var _userList = mutableListOf<UserDisplayBean>()

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
                val curList = _uiState.value.userList
                when (result) {
                    is Result.Success -> {

                        result.data?.let {
                            pageIndex++
                            val newList = convertUserDisplayList(result.data) as MutableList<UserDisplayBean>
                            if (isPullRefresh) {
                                _uiState.value = UserDisplayUIState(newList)
                            } else {
                                // load more or first launch
                                curList.plusAssign(newList)
                                _uiState.value = UserDisplayUIState(curList.toMutableList())
                            }
                        }
                    }
                    is Result.Loading -> {
                        if (isPullRefresh || pageIndex == 1) {
                            _uiState.value =
                                UserDisplayUIState(isLoading = true, isRefreshing = isPullRefresh)
                        } else {
                            // If it loads more data. we need save the current data.
                            _uiState.value =
                                UserDisplayUIState(userList = curList, isLoading = true)
                        }
                    }
                    is Result.Error -> {
                        _uiState.value = UserDisplayUIState(errorMessage = result.extractUIError())
                    }
                }
            }
        }
    }

    fun refreshUserSearching(name: String, isPullRefresh: Boolean = false) {
        pageIndex = 1
//        _userList.clear()
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

    /**
     * Sync follow state from details page come back.
     */
    fun syncUserFollowState(uid: String, following: Boolean) {
        handleFollowStatus(uid) {
            following
        }
    }

    private fun handleFollowStatus(userId: String, block: (() -> Boolean)? = null) {
        val newData = mutableListOf<UserDisplayBean>()
        val oldData = _uiState.value.userList
        oldData.forEach { oldUser ->
            if (oldUser.id == userId) {
                newData.add(oldUser.copy(following = if (block == null) !oldUser.following else block()))
            } else {
                newData.add(oldUser)
            }
        }
        _uiState.value = UserDisplayUIState(newData)
    }

    private fun convertUserDisplayList(userResult: UsersSearchResult): List<UserDisplayBean> {
        return userResult.items.map {
                UserDisplayBean.from(it)
            }.toMutableList()
    }
}