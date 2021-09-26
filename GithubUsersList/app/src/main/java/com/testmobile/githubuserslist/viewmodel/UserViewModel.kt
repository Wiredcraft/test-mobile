package com.testmobile.githubuserslist.viewmodel

import androidx.hilt.Assisted
import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.*
import androidx.paging.cachedIn
import com.testmobile.githubuserslist.api.UserRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

/**
 * [UserViewModel] class to prepare date for the UI -> [MainActivity]
 * @ViewModelInject makes this class to be retrieved and made available to activities
 * */
class UserViewModel @ViewModelInject constructor(
    private val repository: UserRepository,
    @Assisted state: SavedStateHandle
): ViewModel() {
    private val liveData = state.getLiveData(CURRENT_QUERY, DEFAULT_QUERY)

    // return the live date of users to be observed the activity
    val users = liveData.switchMap { queryString ->
        repository.getSearchResults(queryString).cachedIn(viewModelScope)
    }

    // query to get users
    fun searchUsers(query: String) {
        GlobalScope.launch(Dispatchers.Main){
            liveData.postValue(query)
        }

    }

    companion object {
        private const val CURRENT_QUERY = "current_query"
        private const val DEFAULT_QUERY = "android"
    }
}