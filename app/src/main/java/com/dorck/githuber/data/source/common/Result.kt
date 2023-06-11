package com.dorck.githuber.data.source.common

/**
 * A generic class to describe the status of data.
 * @author Dorck
 */
sealed class Result<T>(val data: T? = null, val errCode: Int = 0, val msg: String = "") {
    class Success<T>(data: T) : Result<T>(data)
    class Error<T>(errCode: Int, errorMsg: String = "") : Result<T>(null, errCode, errorMsg)
    class Loading<T> : Result<T>()

    override fun toString(): String {
        return when(this) {
            is Success -> "Success[data=$data]"
            is Error -> "Error[errorCode=$errCode, errorMessage=$msg]"
            is Loading -> "Loading[...]"
        }
    }
}