package xyz.mengxy.githubuserslist.viewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel
import xyz.mengxy.githubuserslist.model.User
import javax.inject.Inject

/**
 * Created by Mengxy on 3/30/22.
 * store user info between two fragment and deal with follow event
 */
@HiltViewModel
class UserDetailViewModel @Inject constructor() : ViewModel() {

    val userLiveData = MutableLiveData<User>()
    val followUserLiveData = MutableLiveData<User>()


    fun setUserInfo(user: User) {
        userLiveData.value = user
    }

    fun followUser(user: User) {
        user.isFollowed = !user.isFollowed
        followUserLiveData.postValue(user)
    }
}
