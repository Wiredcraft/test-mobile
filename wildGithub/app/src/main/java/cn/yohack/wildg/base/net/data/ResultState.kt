package cn.yohack.wildg.base.net.data

import androidx.lifecycle.MutableLiveData
import cn.yohack.wildg.App
import cn.yohack.wildg.base.BizException
import cn.yohack.wildg.base.net.NET_NO_DATA
import cn.yohack.wildg.base.net.handleNetException


/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description 网络请求返回
 **/
sealed class ResultState<out T> {

    companion object {
        /**
         * @param loadingMsg null 不作为   empty 或者显示刷新   text 显示text
         */
        fun <T> onNetLoading(loadingMsg: String?): ResultState<T> = Loading(loadingMsg)

        fun <T> onNetSuccess(data: T): ResultState<T> = Success(data)

        fun <T> onNetFailure(exception: BizException): ResultState<T> = Failure(exception)
    }

    data class Loading(val loadingMsg: String?) : ResultState<Nothing>()

    data class Success<out T>(val value: T) : ResultState<T>()

    data class Failure(val exception: BizException) : ResultState<Nothing>()

}


/**
 * 处理返回结果
 */
fun <T> MutableLiveData<ResultState<T>>.parseResult(result: BaseResponse<T>) {
    value = if (result.success()) {
        result.data?.let {
            ResultState.onNetSuccess(it)
        } ?: kotlin.run {
            ResultState.onNetFailure(BizException(NET_NO_DATA, ""))
        }
    } else {
        ResultState.onNetFailure(
            handleNetException(
                BizException(
                    result.code, result.msg ?: ""
                )
            )
        )
    }
}

/**
 * 不处理返回结果
 */
fun <T> MutableLiveData<ResultState<T>>.parseResult(result: T?) {
    value = if (result == null) {
        ResultState.onNetFailure(BizException(NET_NO_DATA, ""))
    } else {
        ResultState.onNetSuccess(result)
    }
}

/**
 * 异常转换异常处理
 */
fun <T> MutableLiveData<ResultState<T>>.parseException(e: Throwable) {
    value = ResultState.onNetFailure(handleNetException(e))
}
