package com.dorck.githuber.ui.pages.details

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.dorck.githuber.data.GithubDataRepository
import com.dorck.githuber.data.entities.GithubRepo
import com.dorck.githuber.data.source.common.Result
import com.dorck.githuber.data.source.common.extractUIError
import com.dorck.githuber.ui.wrapper.RepoDisplayBean
import com.dorck.githuber.ui.wrapper.RepoDisplayUIState
import com.dorck.githuber.ui.wrapper.UserDisplayBean
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class UserDetailsViewModel @Inject constructor(private val dataRepository: GithubDataRepository) : ViewModel() {
    private var _reposUIState: MutableStateFlow<RepoDisplayUIState> = MutableStateFlow(
        RepoDisplayUIState()
    )
    val reposUIState: StateFlow<RepoDisplayUIState> = _reposUIState.asStateFlow()

    private var _owner: MutableStateFlow<UserDisplayBean?> = MutableStateFlow(null)
    val owner: StateFlow<UserDisplayBean?> = _owner.asStateFlow()

    private var pageIndex = 1

    fun fetchRepos() {
        viewModelScope.launch {
            _owner.value?.run {
                dataRepository.requestRepos(username, pageIndex).collect { result ->
                    when (result) {
                        is Result.Success -> {
                            pageIndex++
                            result.data?.let {
                                val newList = mutableListOf<RepoDisplayBean>()
                                newList.plusAssign(convertRepoDisplayList(result.data))
                                _reposUIState.value = RepoDisplayUIState(newList)
                            }
                        }
                        is Result.Loading -> _reposUIState.value = RepoDisplayUIState(isLoading = true)
                        is Result.Error -> {
                            _reposUIState.value = RepoDisplayUIState(errorMessage = result.extractUIError())
                        }
                    }

                }
            }
        }
    }

    fun startFollow() {
        val oldStateUser = _owner.value
        viewModelScope.launch {
            oldStateUser?.let {
                dataRepository.follow(it.username).collect { result ->
                    if (result is Result.Success) {
                        _owner.value = oldStateUser.copy(following = !it.following)
                    }
                }
            }
        }
    }

    fun updateOwner(owner: UserDisplayBean) {
        _owner.value = owner
    }

    fun resetPage() {
        pageIndex = 1
    }

    private fun convertRepoDisplayList(sourceList: List<GithubRepo>): List<RepoDisplayBean> {
        val uiList = mutableListOf<RepoDisplayBean>()
        sourceList.forEach {
            uiList.add(RepoDisplayBean.from(it))
        }
        return uiList
    }

}