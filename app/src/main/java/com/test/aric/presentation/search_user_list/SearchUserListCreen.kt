package com.test.aric.presentation.search_user_list

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.google.accompanist.swiperefresh.SwipeRefresh
import com.google.accompanist.swiperefresh.rememberSwipeRefreshState
import com.test.aric.presentation.Screen
import com.test.aric.presentation.search_user_list.components.GithubCommonListItem
import com.test.aric.presentation.search_user_list.components.InfiniteListHandler
import com.test.aric.presentation.search_user_list.components.SearchBar

@Composable
fun SearchUserListScreen(
    navController: NavController,
    viewModel: SearchUserListViewModel
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
            .padding(top = 10.dp)
            .padding(horizontal = 20.dp)
    ) {
        val rememberSwipeRefreshState =
            rememberSwipeRefreshState(isRefreshing = viewModel.userList.value.isLoading)
        SearchBar(
            textValue = viewModel.searchInput.value,
            onClick = { viewModel.searchForUsername(it) })
        SwipeRefresh(
            state = rememberSwipeRefreshState,
            onRefresh = { viewModel.searchForUsername(viewModel.searchInput.value) }) {
            val listState = rememberLazyListState()
            LazyColumn(state = listState) {
                itemsIndexed(viewModel.userList.value.lists) { index, it ->
                    with(it) {
                        GithubCommonListItem(
                            avatar_url,
                            login,
                            score,
                            html_url,
                            id,
                            if (it.follow) "不关注" else "关注",
                            { id ->
                                viewModel.updateSelectedUser(id)
                                navController.navigate(Screen.UserDetailScreen.route)
                            },
                            {
                                viewModel.updateFollowStatus(id)
                            },
                            true
                        )
                    }
                }
            }
            InfiniteListHandler(listState = listState, buffer = 5) {
                viewModel.getPagedUserListByName()
            }
        }
    }
}

