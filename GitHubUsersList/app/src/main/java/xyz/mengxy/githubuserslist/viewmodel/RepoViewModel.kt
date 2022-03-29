package xyz.mengxy.githubuserslist.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.paging.PagingData
import androidx.paging.cachedIn
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.Flow
import xyz.mengxy.githubuserslist.model.Repo
import xyz.mengxy.githubuserslist.model.RepoRepository
import javax.inject.Inject

/**
 * Created by Mengxy on 3/29/22.
 */
@HiltViewModel
class RepoViewModel @Inject constructor(
    private val repository: RepoRepository
) : ViewModel() {

    fun getUserRepos(userName: String): Flow<PagingData<Repo>> {
        return repository.getReposResultStream(userName).cachedIn(viewModelScope)
    }
}
