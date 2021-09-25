package com.yxf.mvvmcommon.ktx

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

fun <T> Flow<T>.collectOnCoroutine(
    coroutineScope: CoroutineScope,
    block: (T) -> Unit,
    coroutineContext: CoroutineContext
) {
    val flow = this
    coroutineScope.launch(coroutineContext) {
        flow.collect { block(it) }
    }
}

fun <T> Flow<T>.collectOnCoroutine(coroutineScope: CoroutineScope, block: (T) -> Unit) {
    collectOnCoroutine(coroutineScope, block, Dispatchers.Main)
}