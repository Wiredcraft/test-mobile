package com.test.aric.presentation.viewmodel

import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.test.aric.common.Resource
import com.test.aric.data.remote.dto.RepoInfo
import com.test.aric.data.remote.dto.UserInfo
import com.test.aric.domain.use_case.get_repos.GetReposUseCase
import com.test.aric.domain.use_case.search_users.SearchUsersUseCase
import com.test.aric.presentation.user_detail.GithubListState
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach
import javax.inject.Inject

@HiltViewModel
class GithubActivityViewModel @Inject constructor(
    private val getReposUseCase: GetReposUseCase,
    private val getUserByPageUseCase: SearchUsersUseCase,
) : ViewModel() {

    private var page = 1

    private val _searchInput = mutableStateOf("swift")
    val searchInput: State<String> = _searchInput

    private val _selectedUserInfo = mutableStateOf<UserInfo?>(null)
    val selectedUserInfo: State<UserInfo?> = _selectedUserInfo

    private val _repoList = mutableStateOf<GithubListState<RepoInfo>>(GithubListState<RepoInfo>())
    val repoList: State<GithubListState<RepoInfo>> = _repoList

    private val _userList = mutableStateOf<GithubListState<UserInfo>>(GithubListState<UserInfo>())
    val userList: State<GithubListState<UserInfo>> = _userList

    init {
        getPagedUserListByName()
    }

    fun searchForUsername(userName: String) {
        _searchInput.value = userName
        page = 1
        getPagedUserListByName()
    }

    fun updateSelectedUser(userId: Int) {
        _selectedUserInfo.value = _userList.value.lists.find { it.id == userId }!!
        getOwnerRepoList()
    }

     fun getOwnerRepoList() {
        getReposUseCase(_selectedUserInfo.value!!.login).onEach { result ->
            when (result) {
                is Resource.Success -> {
                    _repoList.value = GithubListState(lists = result.data!!.toMutableList())
                }

                is Resource.Error -> {
                    _repoList.value = GithubListState(
                        error = result.message ?: "An unexpected error occurred"
                    )
                }

                is Resource.Loading -> {
                    _repoList.value = GithubListState(isLoading = true)
                }
            }
        }.launchIn(viewModelScope)
    }

    fun getPagedUserListByName() {
        getUserByPageUseCase(_searchInput.value, page.toString()).onEach {
            when (it) {
                is Resource.Success -> {
                    page++
                    _userList.value =
                        GithubListState(lists = (_userList.value.lists + it.data!!.items).toMutableList())
                }

                is Resource.Error -> {
                    _userList.value = GithubListState(
                        error = it.message ?: "An unexpected error occurred"
                    )
                }

                is Resource.Loading -> {
                    if (page == 1) {
                        _userList.value = GithubListState(isLoading = true)
                    }
                }
            }
        }.launchIn(viewModelScope)
    }

    fun updateFollowStatus(id: Int) {
        val newList = mutableListOf<UserInfo>()
        _userList.value.lists.forEach {
            if (it.id == id) {
                newList.add(it.copy(follow = !it.follow))
            } else {
                newList.add(it)
            }
        }
        if (_selectedUserInfo.value?.id == id){
            _selectedUserInfo.value = selectedUserInfo?.value?.copy(follow = !(selectedUserInfo?.value?.follow?:true))
        }
        _userList.value = GithubListState(lists = newList)
    }
}