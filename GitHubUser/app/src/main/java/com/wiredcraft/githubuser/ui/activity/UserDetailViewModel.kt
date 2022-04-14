package com.wiredcraft.githubuser.ui.activity

import androidx.lifecycle.ViewModel
import com.wiredcraft.githubuser.data.Repository

class UserDetailViewModel : ViewModel() {
    var userRepos =  getRepos()
    private fun getRepos() = Repository.getReposList()
}