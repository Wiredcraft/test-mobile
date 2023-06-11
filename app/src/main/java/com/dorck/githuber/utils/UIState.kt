package com.dorck.githuber.utils

/**
 * A generic class that describe UI state of user operation.
 */
sealed class UIState<out T> {
    data class Success<out T>(val data: T) : UIState<T>()
    object Loading : UIState<Nothing>()
    data class Error(val errorMessage: String) : UIState<Nothing>()
}