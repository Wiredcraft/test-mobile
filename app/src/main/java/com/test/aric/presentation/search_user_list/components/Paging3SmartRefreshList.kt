package com.test.aric.presentation.search_user_list.components

import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.paging.LoadState
import androidx.paging.compose.LazyPagingItems
import com.google.accompanist.swiperefresh.SwipeRefresh
import com.google.accompanist.swiperefresh.rememberSwipeRefreshState

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
