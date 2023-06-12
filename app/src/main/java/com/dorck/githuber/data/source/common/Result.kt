package com.dorck.githuber.data.source.common

/**
 * A generic class to describe the status of data.
 * @author Dorck
 */
sealed class Result<T>(val data: T? = null, val errCode: Int = 0, val msg: String? = null) {
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

fun Result<*>.extractUIError(): String {
    return when (errCode) {
        400 -> "Bad Request or api version is not supported."
        403, 404 -> "Authentication failed or resource cannot be found."
        422 -> "Unprocessable Entity."
        // More troubleshot reference: https://docs.github.com/en/rest/overview/troubleshooting
        else -> msg ?: "Unknown error."
    }
}