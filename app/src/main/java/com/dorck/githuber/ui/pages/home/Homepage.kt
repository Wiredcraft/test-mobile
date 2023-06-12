@file:OptIn(ExperimentalFoundationApi::class)

package com.dorck.githuber.ui.pages.home

import androidx.compose.animation.core.LinearOutSlowInEasing
import androidx.compose.animation.core.tween
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Icon
import androidx.compose.material.Surface
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Warning
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import com.dorck.githuber.R
import com.dorck.githuber.ui.components.*
import com.dorck.githuber.ui.wrapper.UserDisplayBean
import com.google.accompanist.insets.ProvideWindowInsets
import com.google.accompanist.swiperefresh.SwipeRefresh
import com.google.accompanist.swiperefresh.SwipeRefreshState
import com.google.accompanist.swiperefresh.rememberSwipeRefreshState
import com.google.accompanist.systemuicontroller.rememberSystemUiController

const val TAG = "Home"

@Composable
fun Homepage(
    viewModel: HomeUsersViewModel = hiltViewModel(),
    userId: String? = null,
    following: Boolean = false,
    itemClick: (UserDisplayBean) -> Unit
) {
    val userUiState by viewModel.uiState.collectAsState()
    var contentValue by remember { mutableStateOf(TextFieldValue()) }
    ProvideWindowInsets {
        val systemUiController = rememberSystemUiController()
        SideEffect {
            systemUiController.setStatusBarColor(Color.Transparent, darkIcons = true)
        }
        Column(
            Modifier
                .fillMaxSize()
                .background(Color.White)) {
            Spacer(modifier = Modifier.height(18.dp))
            HomeSearchBar(
                query = contentValue,
                searching = userUiState.isLoading,
                onQueryChange = {
                    contentValue = it
                    viewModel.refreshUserSearching(it.text)
                }
            )
            Spacer(modifier = Modifier.height(10.dp))
            val snapshotList = userUiState.userList
            if (userUiState.isLoading) {
                Box(
                    Modifier
                        .fillMaxSize()
                        .background(color = Color.White)
                ) {
                    CircularProgressIndicator(
                        color = Color.Black,
                        modifier = Modifier
                            .padding(horizontal = 6.dp)
                            .size(36.dp)
                            .align(Alignment.Center)
                    )
                }
            } else if (snapshotList.isNotEmpty()) {
                val swipeRefreshState =
                    rememberSwipeRefreshState(isRefreshing = userUiState.isLoading)
                UserListContent(
                    userList = snapshotList,
                    refreshState = swipeRefreshState,
                    onRefresh = {
                        viewModel.refreshUserSearching(contentValue.text, true)
                    },
                    onFollowClick = { id ->
                        viewModel.followUser(id)
                    },
                    onLoadMore = {
                        viewModel.fetchUsers(contentValue.text)
                    },
                    onItemClick = itemClick
                )
            } else {
                ErrorContent(
                    message = userUiState.errorMessage ?: "No github user data was found."
                )
            }
        }
    }
}

@Composable
fun UserListContent(
    modifier: Modifier = Modifier,
    userList: List<UserDisplayBean>,
    refreshState: SwipeRefreshState = SwipeRefreshState(false),
    onRefresh: (() -> Unit)? = null,
    onLoadMore: (() -> Unit)? = null,
    onFollowClick: ((String) -> Unit)? = null,
    onItemClick: ((UserDisplayBean) -> Unit)? = null
) {
    val listState = rememberLazyListState()
    SwipeRefresh(state = refreshState, onRefresh = { onRefresh?.invoke() }) {
        LazyColumn(
            modifier = modifier
                .fillMaxWidth(),
            state = listState
        ) {
            items(items = userList, key = { it.id }) { user ->
                GithubUserListItem(
                    Modifier.animateItemPlacement(
                        animationSpec = tween(
                            durationMillis = 500,
                            easing = LinearOutSlowInEasing,
                        )
                    ),
                    userData = user,
                    text = if (user.following) "取消关注" else "关注",
                    onFollowClick = {
                        onFollowClick?.invoke(user.id)
                    },
                    onItemClick = {
                        onItemClick?.invoke(user)
                    }
                )
            }
        }
        LoadMoreHandler(listState = listState, buffer = 3) {
            onLoadMore?.invoke()
        }
    }
}

@Composable
fun ErrorContent(message: String) {
    Box(
        Modifier
            .fillMaxSize()
            .wrapContentSize()
    ) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Icon(
                imageVector = Icons.Outlined.Warning,
                tint = unselectedIconColor,
                contentDescription = stringResource(R.string.warning_icon_content_desc),
                modifier = Modifier
                    .size(64.dp)
                    .padding(bottom = 12.dp)
            )
            Text(text = message, color = descriptionTextColor, fontSize = 14.sp)
        }
    }
}

@Preview
@Composable
private fun PreviewHomepageLoadingState() {
    Surface(Modifier.fillMaxSize()) {
        Column(
            verticalArrangement = Arrangement.Center,
            modifier = Modifier.windowInsetsPadding(
                WindowInsets.systemBars.only(
                    WindowInsetsSides.Horizontal
                )
            )
        ) {
            Spacer(modifier = Modifier.height(18.dp))
            HomeSearchBar(onQueryChange = {})
            Box(
                Modifier
                    .fillMaxSize()
                    .background(color = Color.White)
            ) {
                CircularProgressIndicator(
                    color = Color.Black,
                    modifier = Modifier
                        .padding(horizontal = 6.dp)
                        .size(36.dp)
                        .align(Alignment.Center)
                )
            }
        }
    }
}

@Preview
@Composable
private fun PreviewHomePageErrorState() {
    Surface(Modifier.fillMaxSize()) {
        Column(
            verticalArrangement = Arrangement.Center,
            modifier = Modifier.windowInsetsPadding(
                WindowInsets.systemBars.only(
                    WindowInsetsSides.Horizontal
                )
            )
        ) {
            Spacer(modifier = Modifier.height(18.dp))
            HomeSearchBar(onQueryChange = {})
            ErrorContent(message = "Network not available!")
        }
    }
}

val mockUserList = listOf(
    UserDisplayBean("1123", "moos", "", "www.weibo.com", "12.3"),
    UserDisplayBean(
        "1124",
        "moosdtassafagaajgagasj;agslagasgnaklnksnkasnk",
        "",
        "www.baidu.com",
        "2.0"
    ),
    UserDisplayBean("1125", "moosphon", "", "www.google.com", "22.1"),
    UserDisplayBean("1126", "moosphan", "", "www.tengxun.com", "60.9"),
    UserDisplayBean("1127", "moostale", "", "www.kuaishou.com", "14.5"),
    UserDisplayBean("1128", "moosli", "", "www.xiaomi.com", "102.0"),
    UserDisplayBean("1129", "mooskia", "", "www.tiktok.com", "12.0"),
)