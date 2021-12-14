package com.lwjlol.github.user.ui

import android.content.Intent
import android.net.Uri
import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import coil.compose.rememberImagePainter
import com.google.accompanist.swiperefresh.SwipeRefresh
import com.google.accompanist.swiperefresh.SwipeRefreshIndicator
import com.google.accompanist.swiperefresh.SwipeRefreshState
import com.google.accompanist.swiperefresh.rememberSwipeRefreshState
import com.lwjlol.github.user.UserRepository
import com.lwjlol.github.user.model.User
import com.lwjlol.github.user.retrofit
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.map

@Composable
fun UserList(viewModel: UserListViewModel) {
    val composableScope = rememberCoroutineScope()
    var viewModelState by remember { mutableStateOf(viewModel.state.value) }
    val swipeRefreshState = rememberSwipeRefreshState(true)
    val listState = rememberLazyListState()
    var showLoadingMore by remember { mutableStateOf(false) }
    var lastVisibleIndex by remember { mutableStateOf(-1) }
    val isLoadMore = viewModelState.page > 1
    if (!isLoadMore) {
        swipeRefreshState.isRefreshing = viewModelState.isLoading
        showLoadingMore = false
    } else {
        swipeRefreshState.isRefreshing = false
        showLoadingMore = viewModelState.isLoading
    }

    DisposableEffect(Unit, effect = {
        viewModel.state.map {
            viewModelState = it
        }.launchIn(composableScope)
        onDispose {}
    })
    SwipeRefresh(modifier = Modifier.fillMaxSize(), state = swipeRefreshState, onRefresh = { viewModel.getUsers(true) }, indicator = { swstate: SwipeRefreshState, refreshTrigger: Dp ->
        SwipeRefreshIndicator(state = swstate, refreshTriggerDistance = refreshTrigger)
    }) {
        LazyColumn(modifier = Modifier.fillMaxSize(), state = listState, content = {
            itemsIndexed(viewModelState.list) { index: Int, item: User ->
                UserItem(user = item)
                if (index == viewModelState.list.lastIndex) {
                    if (showLoadingMore) {
                        Text(
                            modifier = Modifier
                                .fillMaxWidth()
                                .height(50.dp),
                            text = "loading...",
                            color = Color.Blue,
                            textAlign = TextAlign.Center
                        )
                    }
                }
            }
        })
    }
    // load more when scroll to last item
    val index = listState.layoutInfo.visibleItemsInfo.lastOrNull()?.index
    if (viewModelState.list.isNotEmpty() && index == viewModelState.list.lastIndex && lastVisibleIndex != index) {
        viewModel.getUsers(false)
        lastVisibleIndex = index
    }
}

@Composable
fun UserItem(user: User) {
    val context = LocalContext.current
    Row(modifier = Modifier
        .fillMaxWidth()
        .height(100.dp)
        .clickable {
            context.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(user.htmlUrl)))
        }) {
        Image(
            modifier = Modifier
                .size(100.dp)
                .padding(start = 12.dp),
            painter = rememberImagePainter(data = user.avatarUrl),
            contentDescription = user.login
        )
        Spacer(modifier = Modifier.width(24.dp))
        Column(modifier = Modifier.padding(end = 24.dp)) {
            Spacer(modifier = Modifier.height(15.dp))
            Row {
                Text(
                    modifier = Modifier.weight(1F, false),
                    text = user.login,
                    maxLines = 1,
                    fontSize = 15.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.Black,
                    overflow = TextOverflow.Ellipsis
                )
                Spacer(modifier = Modifier.width(5.dp))
                Text(
                    text = user.score,
                    fontSize = 15.sp,
                    fontWeight = FontWeight.Light,
                    overflow = TextOverflow.Visible
                )
            }
            Spacer(modifier = Modifier.height(5.dp))
            Text(
                text = user.htmlUrl,
                fontSize = 13.sp,
                color = Color.Blue,
                maxLines = 1,
                fontWeight = FontWeight.Light,
                overflow = TextOverflow.Ellipsis
            )
        }
    }
}

class UserListViewModel(state: State) : ViewModel() {
    data class State(
        val list: List<User> = emptyList(),
        val page: Int = 1,
        val total: Int = 0,
        val isLoading: Boolean = false,
        val input: String = ""
    )

    private val _state = MutableStateFlow(State())
    val state: StateFlow<State>
        get() = _state
    private val userRepository = UserRepository(retrofit)

    init {
        _state.value = state
        getUsers(true)
    }

    fun getUsers(refresh: Boolean) {
        val page = if (refresh) {
            1
        } else {
            _state.value.page + 1
        }
        _state.value = state.value.copy(page = page, isLoading = true)
        flow {
            emit(page)
        }.flowOn(Dispatchers.IO).map { p ->
            userRepository.getUsers(q = _state.value.input, page = p)
        }.flowOn(Dispatchers.Main).map { (total, list) ->
            if (refresh) {
                _state.value = _state.value.copy(total = total, list = list)
            } else {
                _state.value = _state.value.copy(list = _state.value.list + list)
            }
            _state.value = state.value.copy(page = page, isLoading = false)
        }.launchIn(viewModelScope)
    }

    fun updateInput(text: String) {
        _state.value = _state.value.copy(input = text)
    }

    @Suppress("UNCHECKED_CAST")
    class Factory(val state: State) : ViewModelProvider.Factory {
        override fun <T : ViewModel?> create(modelClass: Class<T>): T {
            return UserListViewModel(state) as T
        }
    }
}

@Composable
fun SearchInput(viewModel: UserListViewModel) {
    val composableScope = rememberCoroutineScope()
    val inputFocusRequester by remember {
        mutableStateOf(FocusRequester())
    }
    var viewModelState by remember { mutableStateOf(viewModel.state.value) }
    DisposableEffect(Unit, effect = {
        // show keyboard
        inputFocusRequester.requestFocus()
        viewModel.state.map {
            viewModelState = it
        }.launchIn(composableScope)
        onDispose {}
    })
    TextField(modifier = Modifier
        .focusRequester(inputFocusRequester)
        .fillMaxWidth(),
        placeholder = {
            Text(text = "input to search")
        },
        value = viewModelState.input,
        singleLine = true,
        maxLines = 1,
        keyboardOptions = KeyboardOptions(imeAction = ImeAction.Search),
        keyboardActions = KeyboardActions(onSearch = {
            viewModel.getUsers(true)
        }),
        onValueChange = { input ->
            viewModel.updateInput(input)
        })
}

