package com.test.aric.presentation.search_user_list

data class SearchUserListState(
    val isLoading: Boolean = false,
    val error: String = "",
    val inputUser: String = "swift",
)
