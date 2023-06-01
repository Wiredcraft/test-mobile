package com.test.aric.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.test.aric.presentation.user_detail.UserDetailScreen
import com.test.aric.presentation.search_user_list.SearchUserListScreen
import com.test.aric.presentation.search_user_list.SearchUserListViewModel
import com.test.aric.presentation.ui.theme.GithubTheme
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class GithubActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
      val  viewModel: SearchUserListViewModel = ViewModelProvider(this)[SearchUserListViewModel::class.java]
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