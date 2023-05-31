package com.wiredcraft.mobileapp.domain

import com.wiredcraft.mobileapp.net.bean.DataResult
import retrofit2.HttpException
import java.net.ConnectException
import java.net.SocketException
import java.net.SocketTimeoutException
import java.net.UnknownHostException

/**
 * createTime：2023/5/29
 * author：lhq
 * desc:
 *
 */

fun <T> DataResult<T>.toUIStateOrThrows() = when {
    isSuccess -> UIState.onSuccess(data)
    else -> throw AppException(error =  errorMsg)
}

fun <T> Throwable.toUIState() = UIState.onError<T>(this.toAppException())

fun <T> DataResult<T>.getSucceedResultOrThrows(): T? {
    return if (isSuccess) data
    else throw AppException(error = errorMsg)
}

fun <T> DataResult<T>.getSucceedResultOrNull(): T? {
    return if (isSuccess) data
    else null
}

fun Throwable.toAppException(): AppException {
    return if (this is AppException) {
        this
    } else {
        val msg = when (this) {
            is SocketTimeoutException -> {
                "请求超时，请稍后再试"
            }
            is ConnectException -> {
                "请检查你的网络连接情况"
            }
            is SocketException -> {
                "网络连接异常，请重试"
            }
            is HttpException -> {
                "服务器异常，请稍后再试"
            }
            is UnknownHostException -> {
                "网络断开，请检查你的网络连接"
            }
            else -> {
                "数据异常，请稍后重试"
            }
        }

        AppException(SYSTEM_ERROR_CODE, msg)
    }
}