package xyz.mengxy.githubuserslist.viewmodel

import androidx.lifecycle.*
import androidx.paging.PagingData
import androidx.paging.cachedIn
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.launch
import xyz.mengxy.githubuserslist.model.User
import xyz.mengxy.githubuserslist.model.UserRepository
import javax.inject.Inject

/**
 * Created by Mengxy on 3/29/22.
 * store query info in `state` : [SavedStateHandle]
 */
@HiltViewModel
class UserViewModel @Inject constructor(
    private val repository: UserRepository,
    private val state: SavedStateHandle
) : ViewModel() {

    private val currentQueryStateFlow: MutableStateFlow<String> = MutableStateFlow(
        state.get(QUERY_SAVED_STATE_KEY) ?: DEFAULT_QUERY
    )

    private var currentQueryStr: String = DEFAULT_QUERY

    @ExperimentalCoroutinesApi
    val searchLiveData: LiveData<PagingData<User>> = currentQueryStateFlow.flatMapLatest { query ->
        repository.getSearchResultStream(query).cachedIn(viewModelScope)
    }.asLiveData()

    companion object {
        private const val QUERY_SAVED_STATE_KEY = "query_saved_state_key"
        private const val DEFAULT_QUERY = "kotlin"
    }

    init {
        viewModelScope.launch {
            currentQueryStateFlow.collect { queryStr ->
                state.set(QUERY_SAVED_STATE_KEY, queryStr)
            }
        }
    }

    // search by default query key first time, when activity rotate search by current query key
    fun searchUsers() {
        currentQueryStateFlow.value = currentQueryStr
    }

    fun searchUsers(queryStr: String) {
        currentQueryStr = queryStr
        currentQueryStateFlow.value = queryStr
    }
}
