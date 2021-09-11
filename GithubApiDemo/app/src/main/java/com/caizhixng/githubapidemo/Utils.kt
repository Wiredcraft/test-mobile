package com.caizhixng.githubapidemo

import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import java.util.concurrent.Flow

/**
 * czx 2021/9/11
 */


//inline fun <T> Flow<T>.launchAndCollectIn(
//    owner: LifecycleOwner,
//    minActiveState: Lifecycle.State = Lifecycle.State.STARTED,
//    crossinline action: suspend CoroutineScope.(T) -> Unit
//) = owner.lifecycleScope.launch {
//    owner.lifecycle.repeatOnLifecycle(minActiveState) {
//        collect {
//            action(it)
//        }
//    }
//}