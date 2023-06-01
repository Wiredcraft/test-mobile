package com.test.aric.presentation.user_detail

import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.google.gson.Gson
import com.test.aric.common.Constants
import com.test.aric.common.Resource
import com.test.aric.data.remote.dto.UserInfo
import com.test.aric.domain.use_case.get_repos.GetReposUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach
import javax.inject.Inject

@HiltViewModel
class UserDetailViewModel @Inject constructor(
    private val getReposUseCase: GetReposUseCase,
    savedStateHandle: SavedStateHandle
) : ViewModel() {

    lateinit var userInfo: UserInfo

    private val _repoList = mutableStateOf<UserDetailState>(UserDetailState())
    val repoList: State<UserDetailState> = _repoList

    init {
        savedStateHandle.get<String>(Constants.PARAM_USER_INFO)?.let { user ->
            userInfo = Gson().fromJson(user, UserInfo::class.java)
        }

        getAllRepos()
    }


    fun getAllRepos() {
        getReposUseCase(userInfo.login).onEach { result ->
            when (result) {
                is Resource.Success -> {
                    _repoList.value = UserDetailState(lists = result.data!!)
                }

                is Resource.Error -> {
                    _repoList.value = UserDetailState(
                        error = result.message ?: "An unexpected error occurred"
                    )
                }

                is Resource.Loading -> {
                    _repoList.value = UserDetailState(isLoading = true)
                }
            }
        }.launchIn(viewModelScope)
    }
}
