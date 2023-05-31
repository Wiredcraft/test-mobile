package com.wiredcraft.mobileapp.ui.userdetail

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.wiredcraft.mobileapp.bean.RepositoryBean
import com.wiredcraft.mobileapp.domain.UIState
import com.wiredcraft.mobileapp.domain.repository.UserRepository
import kotlinx.coroutines.launch

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: the viewModel for [UserDetailActivity]
 *
 */
class UserDetailViewModel : ViewModel() {

    private val _repository = MutableLiveData<UIState<List<RepositoryBean>?>>()
    val repositorySource: LiveData<UIState<List<RepositoryBean>?>> = _repository

    /**
     * part of datasource
     */
    var userBean = MutableLiveData<UserDetailBean>()


    private val repositoryEngine = UserRepository()

    /**
     * query user repositories
     * @param userName the name of user
     */
    fun queryUserRepositories(userName: String) {
        viewModelScope.launch {
            repositoryEngine.queryUserRepositories(userName).collect {
                _repository.value = it
            }
        }
    }

}