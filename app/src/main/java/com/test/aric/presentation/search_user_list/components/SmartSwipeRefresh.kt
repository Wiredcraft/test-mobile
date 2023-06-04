package com.test.aric.presentation.search_user_list.components


import android.util.Log
import androidx.compose.animation.core.Animatable
import androidx.compose.animation.core.VectorConverter
import androidx.compose.animation.core.tween
import androidx.compose.foundation.MutatePriority
import androidx.compose.foundation.MutatorMutex
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.offset
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.input.nestedscroll.NestedScrollConnection
import androidx.compose.ui.input.nestedscroll.NestedScrollSource
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.layout.SubcomposeLayout
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.Constraints
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.Velocity
import androidx.compose.ui.unit.coerceAtLeast
import androidx.compose.ui.unit.coerceAtMost
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow

class SmartSwipeRefreshState {
    private val mutatorMutex = MutatorMutex()
    private val indicatorOffsetAnimatable = Animatable(0.dp, Dp.VectorConverter)
    val indicatorOffset get() = indicatorOffsetAnimatable.value
    private val _indicatorOffsetFlow  = MutableStateFlow(0f)
    val indicatorOffsetFlow: Flow<Float> get() = _indicatorOffsetFlow
    val isSwipeInProgress by derivedStateOf { indicatorOffset != 0.dp }

    var isRefreshing: Boolean by mutableStateOf(false)

    fun updateOffsetDelta(value: Float) {
        _indicatorOffsetFlow.value = value
    }

    suspend fun snapToOffset(value: Dp) {
        mutatorMutex.mutate(MutatePriority.UserInput) {
            indicatorOffsetAnimatable.snapTo(value)
        }
    }

    suspend fun animateToOffset(value: Dp) {
        mutatorMutex.mutate {
            indicatorOffsetAnimatable.animateTo(value, tween(1000))
        }
    }
}

private class SmartSwipeRefreshNestedScrollConnection(
    val state: SmartSwipeRefreshState,
    val height: Dp
): NestedScrollConnection {
    override fun onPreScroll(available: Offset, source: NestedScrollSource): Offset {
        Log.d("aric", "onPreScroll")
        return if (source == NestedScrollSource.Drag && available.y < 0) {
            state.updateOffsetDelta(available.y)
            if (state.isSwipeInProgress) Offset(x = 0f, y = available.y) else Offset.Zero
        } else {
            Offset.Zero
        }
    }

    override fun onPostScroll(
        consumed: Offset,
        available: Offset,
        source: NestedScrollSource
    ): Offset {
        Log.d("aric", "onPostScroll")
        return if (source == NestedScrollSource.Drag && available.y > 0) {
            state.updateOffsetDelta(available.y)
            Offset(x = 0f, y = available.y)
        } else {
            Offset.Zero
        }
    }

    override suspend fun onPreFling(available: Velocity): Velocity {
        Log.d("aric", "onPreFling")
        if (state.indicatorOffset > height / 2) {
            state.animateToOffset(height)
            state.isRefreshing = true
        } else {
            state.animateToOffset(0.dp)
        }
        return super.onPreFling(available)
    }

    override suspend fun onPostFling(consumed: Velocity, available: Velocity): Velocity {
        Log.d("aric", "onPostFling")
        return super.onPostFling(consumed, available)
    }
}

@Composable
private fun SubComposeSmartSwipeRefresh(
    indicator: @Composable () -> Unit,
    content: @Composable (Dp) -> Unit
) {
    SubcomposeLayout { constraints: Constraints ->
        var indicatorPlaceable = subcompose("indicator", indicator).first().measure(constraints)
        var contentPlaceable = subcompose("content") {
            content(indicatorPlaceable.height.toDp())
        }.map {
            it.measure(constraints)
        }.first()
        Log.d("aric","dp: ${indicatorPlaceable.height.toDp()}")
        layout(contentPlaceable.width, contentPlaceable.height) {
            contentPlaceable.placeRelative(0, 0)
        }
    }
}

@Composable
fun SmartSwipeRefresh(
    onRefresh: suspend () -> Unit,
    state: SmartSwipeRefreshState = remember { SmartSwipeRefreshState() },
    loadingIndicator: @Composable () -> Unit = { CircularProgressIndicator() },
    content: @Composable () -> Unit
) {
    SubComposeSmartSwipeRefresh(indicator = loadingIndicator) { height ->
        val smartSwipeRefreshNestedScrollConnection = remember(state, height) {
            SmartSwipeRefreshNestedScrollConnection(state, height)
        }
        Box(
            Modifier
                .nestedScroll(smartSwipeRefreshNestedScrollConnection),
            contentAlignment = Alignment.TopCenter
        ) {
            Box(Modifier.offset(y = -height + state.indicatorOffset)) {
                loadingIndicator()
            }
            Box(Modifier.offset(y = state.indicatorOffset)) {
                content()
            }
        }
        var density = LocalDensity.current
        LaunchedEffect(Unit) {
            state.indicatorOffsetFlow.collect {
                var currentOffset = with(density) { state.indicatorOffset + it.toDp() }
                state.snapToOffset(currentOffset.coerceAtLeast(0.dp).coerceAtMost(height))
            }
        }
        LaunchedEffect(state.isRefreshing) {
            if (state.isRefreshing) {
                onRefresh()
                state.animateToOffset(0.dp)
                state.isRefreshing = false
            }
        }
    }
}