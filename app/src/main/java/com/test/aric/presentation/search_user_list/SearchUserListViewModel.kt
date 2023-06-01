package com.test.aric.presentation.search_user_list

import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.paging.InvalidatingPagingSourceFactory
import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.cachedIn
import androidx.paging.compose.collectAsLazyPagingItems
import com.test.aric.common.Resource
import com.test.aric.data.remote.dto.UserInfo
import com.test.aric.domain.repository.GithubRepository
import com.test.aric.domain.use_case.get_repos.GetReposUseCase
import com.test.aric.presentation.user_detail.UserDetailState
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class SearchUserListViewModel @Inject constructor(
    private val getReposUseCase: GetReposUseCase,
    private val githubRepository: GithubRepository
) : ViewModel() {

    private val _userName = mutableStateOf("swift")
    val userName: State<String> = _userName

    public lateinit var selectedUserInfo:UserInfo

    private val _repoList = mutableStateOf<UserDetailState>(UserDetailState())
    val repoList: State<UserDetailState> = _repoList

   private  val invalidatingFactory = InvalidatingPagingSourceFactory {
        UserListDataSource(_userName.value, githubRepository)
    }

    val pagingFlow = Pager(config = PagingConfig(30)) {
        invalidatingFactory()
    }.flow.cachedIn(viewModelScope)


    fun searchForUsername(userName: String) {
        _userName.value = userName
        invalidatingFactory.invalidate()
    }

    fun updateSelectedUser(user:UserInfo){
        selectedUserInfo = user
        getAllRepos()
    }

    fun getAllRepos() {
        getReposUseCase(_userName.value).onEach { result ->
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