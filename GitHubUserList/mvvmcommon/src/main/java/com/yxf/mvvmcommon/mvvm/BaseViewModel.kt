package com.yxf.mvvmcommon.mvvm

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import kotlinx.coroutines.launch

open class BaseViewModel : ViewModel() {


    fun startCoroutine(block: suspend CoroutineScope.() -> Unit) {
        viewModelScope.launch(Dispatchers.Main) { block(this) }
    }

    fun <R> toFlow(block: suspend () -> R): Flow<R> {
        return flow<R> { emit(block()) }.flowOn(Dispatchers.IO)
    }

    fun <R> getResultToLiveData(block: suspend () -> R, liveData: MutableLiveData<R>) {
        startCoroutine {
            val deferred = async(Dispatchers.IO) {
                return@async block()
            }
            val result = deferred.await()
            liveData.value = result
        }
    }


}