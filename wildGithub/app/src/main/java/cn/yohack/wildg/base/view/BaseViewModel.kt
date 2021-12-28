package cn.yohack.wildg.base.view

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import cn.yohack.wildg.base.BizException
import cn.yohack.wildg.base.net.NET_NO_DATA
import cn.yohack.wildg.base.net.data.BaseResponse
import cn.yohack.wildg.base.net.data.ResultState
import cn.yohack.wildg.base.net.data.parseException
import cn.yohack.wildg.base.net.data.parseResult
import cn.yohack.wildg.base.net.handleNetException
import kotlinx.coroutines.*


/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description  base viewModel
 **/
open class BaseViewModel : ViewModel() {

    /**
     * ui Loading
     */
    val loadingChange: MutableLiveData<Pair<Int?, String?>> by lazy {
        MutableLiveData<Pair<Int?, String?>>()
    }

    /**
     * for toast errorMsg
     */
    val toastMsg: MutableLiveData<String> by lazy {
        MutableLiveData<String>()
    }


    /**
     * request network
     */
    protected fun <T> request(
        query: suspend (CoroutineScope) -> BaseResponse<T>,
        success: (T) -> Unit,
        error: ((BizException) -> Unit)? = {
            // default toast msg
            hideAction?.invoke()
            toastMsg.postValue(it.message)
        },
        loadingMsg: String? = null,
        hideAction: (() -> Unit)? = {
            // default hide loading
            postLoading(TAG_LOADING_HIDE, loadingMsg)
        }
    ): Job {
        val coroutineExceptionHandler = CoroutineExceptionHandler { _, e ->
            val newError = handleNetException(e)
            error?.invoke(newError)
        }

        //show loading
        if (loadingMsg.isNullOrBlank().not()) {
            postLoading(TAG_LOADING_SHOW, loadingMsg)
        }

        return viewModelScope.launch(Dispatchers.IO + coroutineExceptionHandler) {
            val result = query.invoke(this)

            if (result.success()) {
                hideAction?.invoke()
                val data = result.data
                data?.let(success) ?: kotlin.run {
                    throw BizException(NET_NO_DATA, "")
                }
            } else {
                val code = result.code
                val msg = result.msg ?: ""
                throw BizException(code, msg)
            }
        }

    }


    protected fun postLoading(tag: Int, msg: String?) {
        loadingChange.postValue(Pair(tag, msg))
    }

}