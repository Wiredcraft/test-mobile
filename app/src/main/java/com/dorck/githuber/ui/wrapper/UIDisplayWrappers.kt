package com.dorck.githuber.ui.wrapper

import com.dorck.githuber.data.entities.GithubUser

data class UserDisplayBean(
    val id: String,
    val username: String,
    val avatar: String,
    val profileUrl: String,
    val score: String
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