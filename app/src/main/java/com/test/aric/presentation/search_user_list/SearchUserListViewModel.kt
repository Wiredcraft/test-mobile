package com.test.aric.presentation.search_user_list

import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.paging.InvalidatingPagingSourceFactory
import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.cachedIn
import com.test.aric.domain.repository.GithubRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import javax.inject.Inject

@HiltViewModel
class SearchUserListViewModel @Inject constructor(
    private val githubRepository: GithubRepository
) : ViewModel() {

    private val _userName = mutableStateOf("swift")
    val userName: State<String> = _userName

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
}