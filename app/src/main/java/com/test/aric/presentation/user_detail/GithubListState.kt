package com.test.aric.presentation.user_detail

data class GithubListState<T>(
    val isLoading: Boolean = false,
    val lists: MutableList<T> = mutableListOf(),
    val error: String = ""
)
