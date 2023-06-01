package com.test.aric.presentation.user_detail

import com.test.aric.data.remote.dto.RepoInfo

data class UserDetailState(
    val isLoading: Boolean = false,
    val lists: List<RepoInfo> = emptyList(),
    val error: String = ""
)
