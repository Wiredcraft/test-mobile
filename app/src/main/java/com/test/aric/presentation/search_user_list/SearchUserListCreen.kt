package com.test.aric.presentation.search_user_list

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import androidx.paging.LoadState
import androidx.paging.compose.LazyPagingItems
import androidx.paging.compose.collectAsLazyPagingItems
import com.google.accompanist.swiperefresh.SwipeRefresh
import com.google.accompanist.swiperefresh.rememberSwipeRefreshState
import com.google.gson.Gson
import com.test.aric.R
import com.test.aric.presentation.Screen
import com.test.aric.presentation.search_user_list.components.SearchUserListItem

@Composable
fun SearchUserListScreen(
    navController: NavController,
    viewModel: SearchUserListViewModel
) {
    val lazyPagingItems = viewModel.pagingFlow.collectAsLazyPagingItems()

    var text = remember { mutableStateOf(TextFieldValue( viewModel.userName.value)) }

    Column(
        modifier = Modifier
            .fillMaxSize()

            .background(Color.White)
            .padding(horizontal = 20.dp)
    ) {
        TextField(
            value = text.value,
            onValueChange = { text.value = it},
            modifier = Modifier
                .fillMaxWidth()
                .padding(vertical = 10.dp)
                .background(color = Color(0xFFF5F5F5), shape = RoundedCornerShape(30.dp))
                .padding(horizontal = 10.dp, vertical = 2.dp)
            ,

            singleLine = true,
            textStyle = TextStyle(color= Color.Black),
            trailingIcon = {
                IconButton(onClick = {
                    viewModel.searchForUsername(text.value.text)
                }) {
                    Icon(painterResource(id = R.drawable.ic_search), null)
                }
            },
        )
        
        

        SwipeRefreshList(lazyPagingItems) {
            itemsIndexed(lazyPagingItems.itemSnapshotList.items) { index, user ->

                SearchUserListItem(
                    index,
                    userInfo = user,
                    onItemClick = {
                        viewModel.updateSelectedUser(user)
                        navController.navigate(Screen.UserDetailScreen.route)
                    },
                    onFollowButtonClick = {

                    }
                )
            }
        }
    }
}


@Composable
fun <T : Any> SwipeRefreshList(
    collectAsLazyPagingItems: LazyPagingItems<T>,
    content: LazyListScope.() -> Unit
) {
    val rememberSwipeRefreshState = rememberSwipeRefreshState(isRefreshing = false)
    SwipeRefresh(
        state = rememberSwipeRefreshState,
        onRefresh = { collectAsLazyPagingItems.refresh() }) {

        rememberSwipeRefreshState.isRefreshing =
            collectAsLazyPagingItems.loadState.refresh is LoadState.Loading

        LazyColumn(
            modifier = Modifier
                .fillMaxHeight()
                .fillMaxWidth(),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {

            content()

            collectAsLazyPagingItems.apply {
                when {
                    loadState.append is LoadState.Loading -> {//加载更多时，就在底部显示loading的item
                        item { LoadingItem() }
                    }

                    loadState.append is LoadState.Error -> {//加载更多的时候出错了，就在底部显示错误的item
                        item {
                            ErrorItem() {
                                collectAsLazyPagingItems.retry()
                            }
                        }
                    }

                    loadState.refresh is LoadState.Error -> {
                        if (collectAsLazyPagingItems.itemCount <= 0) {
                            item {
                                ErrorContent() {
                                    collectAsLazyPagingItems.retry()
                                }
                            }
                        } else {
                            item {
                                ErrorItem() {
                                    collectAsLazyPagingItems.retry()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


@Composable
fun ErrorItem(retry: () -> Unit) {
    Button(onClick = { retry() }, modifier = Modifier.padding(10.dp)) {
        Text(text = "重试")
    }
}

@Composable
fun ErrorContent(retry: () -> Unit) {
    Text(text = "请求出错啦")
    Button(onClick = { retry() }, modifier = Modifier.padding(10.dp)) {
        Text(text = "重试")
    }
}

@Composable
fun LoadingItem() {
    CircularProgressIndicator(modifier = Modifier.padding(10.dp))
}
