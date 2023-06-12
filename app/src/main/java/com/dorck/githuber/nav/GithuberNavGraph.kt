package com.dorck.githuber.nav

import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Modifier
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.dorck.githuber.ui.pages.details.UserDetails
import com.dorck.githuber.ui.pages.details.UserDetailsViewModel
import com.dorck.githuber.ui.pages.home.HomeUsersViewModel
import com.dorck.githuber.ui.pages.home.Homepage
import kotlinx.coroutines.CoroutineScope

@Composable
fun GithuberNavGraph(
    modifier: Modifier = Modifier,
    navController: NavHostController = rememberNavController(),
    coroutineScope: CoroutineScope = rememberCoroutineScope(),
    startDestination: String = GithuberDestinations.HOME_ROUTE
) {
    val homeUsersViewModel: HomeUsersViewModel = hiltViewModel()
    val userDetailsViewModel: UserDetailsViewModel = hiltViewModel()

    NavHost(
        modifier = modifier,
        navController = navController,
        startDestination = startDestination
    ) {
        composable(
            GithuberDestinations.HOME_ROUTE,
            arguments = listOf(
                navArgument(GithuberDestinations.USER_ID_ARGS) {
                    type = NavType.StringType; nullable = true
                },
                navArgument(GithuberDestinations.USER_FOLLOWING_STATE) {
                    type = NavType.BoolType; nullable = false
                }
            )
        ) { entry ->
            Homepage(
                homeUsersViewModel,
                userId = entry.arguments?.getString(GithuberDestinations.USER_ID_ARGS),
                following = entry.arguments?.getBoolean(GithuberDestinations.USER_FOLLOWING_STATE) ?: false
            ) {
                userDetailsViewModel.updateOwner(it)
                navController.navigate("${GithuberDestinations.USER_DETAILS_PAGE}?${GithuberDestinations.USER_ID_ARGS}=${it.id}")
            }
        }
        composable(
            GithuberDestinations.USER_DETAILS_ROUTE,
            arguments = listOf(
                navArgument(GithuberDestinations.USER_ID_ARGS) {
                    type = NavType.StringType; nullable = true
                },
            )) { entry ->
            UserDetails(
                userDetailsViewModel,
                id = entry.arguments?.getString(GithuberDestinations.USER_ID_ARGS) ?: ""
            ) { uid, isFollowed ->
                // Back to homepage.
//                navController.navigate("${GithuberDestinations.HOME_PAGE}?${GithuberDestinations.USER_ID_ARGS}=$uid" +
//                        "&${GithuberDestinations.USER_FOLLOWING_STATE}=$isFollowed")
                homeUsersViewModel.syncUserFollowState(uid, isFollowed)
                navController.popBackStack()
            }
        }
    }
}