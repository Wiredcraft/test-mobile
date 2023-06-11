package com.dorck.githuber.ui.pages.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.dorck.githuber.data.GithubDataRepository
import com.dorck.githuber.data.entities.UsersSearchResult
import com.dorck.githuber.data.source.common.Result
import com.dorck.githuber.ui.wrapper.UserDisplayBean
import com.dorck.githuber.utils.UIState
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
class HomeUsersViewModel @Inject constructor(private val dataRepository: GithubDataRepository) : ViewModel() {

    private val _uiState: MutableStateFlow<UIState<List<UserDisplayBean>>> = MutableStateFlow(UIState.Loading)
    val uiState: StateFlow<UIState<List<UserDisplayBean>>> = _uiState.asStateFlow()


    init {
        // Need to fetch default users at first launch.
        fetchUsers()
    }

    /**
     * Search for github users with [username].
     */
    fun fetchUsers(username: String = "android", pageIndex: Int = 1, perPage: Int = 30) {
        viewModelScope.launch {
            dataRepository.searchUsers(username, pageIndex, perPage).collect { result ->
                when(result) {
                    is Result.Success -> {
                        result.data?.let {
                            _uiState.value = UIState.Success(convertUserDisplayList(result.data))
                        }
                    }
                    is Result.Loading -> _uiState.value = UIState.Loading
                    is Result.Error -> _uiState.value = convertUIError(result)
                }
            }
        }
    }

    private fun convertUIError(errorData: Result.Error<UsersSearchResult>): UIState.Error {
        val msg = when(errorData.errCode) {
            400 -> "Bad Request or api version is not supported."
            404 -> "Authentication failed or resource cannot be found."
            422 -> "Unprocessable Entity."
            // More troubleshot reference: https://docs.github.com/en/rest/overview/troubleshooting
            else -> errorData.msg
        }
        return UIState.Error(msg)
    }

    private fun convertUserDisplayList(userResult: UsersSearchResult): List<UserDisplayBean> {
        return userResult.items.map {
            UserDisplayBean.from(it)
        }
    }
}