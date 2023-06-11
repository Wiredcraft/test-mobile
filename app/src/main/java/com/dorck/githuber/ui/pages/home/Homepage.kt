package com.dorck.githuber.ui.pages.home

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListState
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Icon
import androidx.compose.material.Surface
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.Warning
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.dorck.githuber.ui.components.GithubUserListItem
import com.dorck.githuber.ui.components.HomeSearchBar
import com.dorck.githuber.ui.wrapper.UserDisplayBean
import androidx.lifecycle.viewmodel.compose.viewModel
import com.dorck.githuber.R
import com.dorck.githuber.ui.components.descriptionTextColor
import com.dorck.githuber.ui.components.unselectedIconColor
import com.dorck.githuber.utils.UIState


@Composable
fun Homepage(viewModel: HomeUsersViewModel = viewModel()) {
    val uiState by viewModel.uiState.collectAsState()
    val listState = rememberLazyListState()
    Surface(Modifier.fillMaxSize()) {
        Column(
            verticalArrangement = Arrangement.Center,
            modifier = Modifier.windowInsetsPadding(
                WindowInsets.systemBars.only(WindowInsetsSides.Horizontal)
            )
        ) {
            Spacer(modifier = Modifier.height(18.dp))
            HomeSearchBar(onQueryChange = {})
            Spacer(modifier = Modifier.height(24.dp))
            when (uiState) {
                is UIState.Loading -> {
                    Box(
                        Modifier
                            .fillMaxSize()
                            .background(color = Color.White)
                    ) {
                        CircularProgressIndicator(
                            color = Color.Black,
                            modifier = Modifier
                                .padding(horizontal = 6.dp)
                                .size(ButtonDefaults.IconSize)
                                .align(Alignment.Center)
                        )
                    }
                }
                is UIState.Error -> {
                    ErrorContent(message = (uiState as UIState.Error).errorMessage)
                }
                is UIState.Success -> {
                    UserListContent(
                        userLazyListState = listState,
                        userList = (uiState as UIState.Success<List<UserDisplayBean>>).data
                    )
                }

            }

        }
    }
}

@Composable
fun UserListContent(
    modifier: Modifier = Modifier,
    userLazyListState: LazyListState? = null,
    userList: List<UserDisplayBean>
) {
    Box(modifier = modifier) {
        LazyColumn(
            modifier = modifier
                .fillMaxWidth()
                .padding(top = 24.dp),
//            state = userLazyListState
        ) {
            items(items = userList, key = { it.id }) { user ->
                GithubUserListItem(userData = user)
            }
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
            Spacer(modifier = Modifier.height(20.dp))

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

@Preview
@Composable
private fun PreviewHomepageSuccessState() {
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
            UserListContent(Modifier.fillMaxSize(), userList = mockUserList)
        }
    }
}

val mockUserList = listOf<UserDisplayBean>(
    UserDisplayBean("1123", "moos", "", "www.weibo.com", "12.3"),
    UserDisplayBean("1124", "moosdtas", "", "www.baidu.com", "2.0"),
    UserDisplayBean("1125", "moosphon", "", "www.google.com", "22.1"),
    UserDisplayBean("1126", "moosphan", "", "www.tengxun.com", "60.9"),
    UserDisplayBean("1127", "moostale", "", "www.kuaishou.com", "14.5"),
    UserDisplayBean("1128", "moosli", "", "www.xiaomi.com", "102.0"),
    UserDisplayBean("1129", "mooskia", "", "www.tiktok.com", "12.0"),
)