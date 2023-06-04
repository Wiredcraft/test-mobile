package com.test.aric.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.test.aric.presentation.search_user_list.SearchUserListScreen
import com.test.aric.presentation.viewmodel.GithubActivityViewModel
import com.test.aric.presentation.ui.theme.GithubTheme
import com.test.aric.presentation.user_detail.UserDetailScreen
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class GithubActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
      val  viewModel: GithubActivityViewModel = ViewModelProvider(this)[GithubActivityViewModel::class.java]
        setContent {
            GithubTheme {
                Surface(color = MaterialTheme.colors.background) {
                    val navController = rememberNavController()

                    NavHost(
                        navController = navController,
                        startDestination = Screen.UserListScreen.route
                    ) {
                        composable(
                            route = Screen.UserListScreen.route
                        ) {
                            SearchUserListScreen(navController,viewModel)
                        }
                        composable(
                            route = Screen.UserDetailScreen.route
                        ) {
                            UserDetailScreen(viewModel)
                        }
                    }
                }
            }
        }
    }
}