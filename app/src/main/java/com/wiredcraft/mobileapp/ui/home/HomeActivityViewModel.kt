package com.wiredcraft.mobileapp.ui.home

import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.bumptech.glide.Glide.init
import com.wiredcraft.mobileapp.bean.UserBean
import com.wiredcraft.mobileapp.domain.UIState
import com.wiredcraft.mobileapp.domain.repository.UserRepository
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch

/**
 * createTime：2023/5/29
 * author：lhq
 * desc: the viewModel for [MainActivity]
 *
 */
class HomeActivityViewModel: ViewModel() {

    private val _users = MutableLiveData<HomePageUIState>()
    val users: LiveData<HomePageUIState> = _users

    val queryWords = MutableLiveData<String>()

    private val repository = UserRepository()

    private var page = 1

    val defaultQueryWord = "Android"

    init {
        queryWords.value = defaultQueryWord
    }

    private fun pagePlus() {
        page.plus(1)
    }

    private fun pageMinus() {
        page.minus(1)
    }

    fun queryUsers(queryWords: String, isRefresh: Boolean) {
        if (isRefresh) {
            page = 1
        } else {
            pagePlus()
        }
        viewModelScope.launch {
            repository.queryUsers(queryWords, page).collect {
                if (it is UIState.Error) {
                    pageMinus()
                }
                _users.value = HomePageUIState(isRefresh, it)
            }
        }
    }
}

class HomePageUIState(
    val isRefresh: Boolean,
    val uiState: UIState<List<UserBean>?>
)