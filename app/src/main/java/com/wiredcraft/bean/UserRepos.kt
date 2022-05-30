package com.wiredcraft.bean

data class UserReposInfo(
    val name: String = "",
    val html_url: String = "",
    val stargazers_count: Int = 0,
    val owner: RepoOwner = RepoOwner()
)

data class RepoOwner(
    val avatar_url: String = "",
)