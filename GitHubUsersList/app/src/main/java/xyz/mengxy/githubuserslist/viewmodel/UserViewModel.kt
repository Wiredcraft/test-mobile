package xyz.mengxy.githubuserslist.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.paging.PagingData
import androidx.paging.cachedIn
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.Flow
import xyz.mengxy.githubuserslist.model.User
import xyz.mengxy.githubuserslist.model.UserRepository
import javax.inject.Inject

/**
 * Created by Mengxy on 3/29/22.
 */
@HiltViewModel
class UserViewModel @Inject constructor(
    private val repository: UserRepository
) : ViewModel() {

    fun searchUsers(queryStr: String): Flow<PagingData<User>> {
        return repository.getSearchResultStream(queryStr).cachedIn(viewModelScope)
    }
}
