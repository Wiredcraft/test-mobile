package com.test.aric.presentation

sealed class Screen(val route: String) {
    object UserListScreen: Screen("github_user_list_screen")
    object UserDetailScreen: Screen("github_user_detail_screen")
}
