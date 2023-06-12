package com.dorck.githuber.ui.wrapper

import com.dorck.githuber.data.entities.GithubRepo
import com.dorck.githuber.data.entities.GithubUser

data class UserDisplayUIState(
    val userList: MutableList<UserDisplayBean> = mutableListOf(),
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val isRefreshing: Boolean = false
)

data class RepoDisplayUIState(
    val repoList: List<RepoDisplayBean> = emptyList(),
    val isLoading: Boolean = false,
    val errorMessage: String? = null
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

data class RepoDisplayBean(
    val id: String,
    val repoName: String,
    val ownerAvatar: String,
    val repoUrl: String,
    val stargazer: String,
) {
    companion object {
        fun from(repo: GithubRepo): RepoDisplayBean {
            return with(repo) {
                RepoDisplayBean(
                    id.toString(),
                    name,
                    owner.avatar_url,
                    html_url,
                    stargazers_count.toString()
                )
            }
        }
    }
}