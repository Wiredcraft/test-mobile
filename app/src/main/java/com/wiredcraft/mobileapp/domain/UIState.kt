package com.wiredcraft.mobileapp.domain

sealed class UIState<out V> {
    companion object {
        fun <V> onSuccess(data: V): UIState<V> = Success(data)
        fun <V> onLoading(loadingMessage: String? = null): UIState<V> = Loading(loadingMessage)
        fun <V> onError(error: AppException): UIState<V> = Error(error)
        /**
         * 自定义状态，上面状态不够用的时候可以启用这个状态
         */
        fun <V> onState(what: Any? = null): UIState<V> = State(what)
    }

    data class Loading(val loadingMessage: String? = null) : UIState<Nothing>()
    data class Success<out V>(val data: V) : UIState<V>()
    data class Error(val error: AppException) : UIState<Nothing>()
    data class State(val what: Any? = null) : UIState<Nothing>()
}
