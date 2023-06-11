package com.dorck.githuber.ui.wrapper

import com.dorck.githuber.data.entities.GithubUser

data class UserDisplayUIState(
    val userList: List<UserDisplayBean> = emptyList(),
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val isRefreshing: Boolean = false
)

data class UserDisplayBean(
    val id: String,
    val username: String,
    val avatar: String,
    val profileUrl: String,
    val score: String,
    val following: Boolean = false
) {
    companion object {
        fun from(user: GithubUser): UserDisplayBean {
            return with(user) {
                UserDisplayBean(
                    id.toString(),
                    login,
                    avatar_url,
                    html_url,
                    score.toString()
                )
            }
        }
    }
}