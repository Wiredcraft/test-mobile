package cn.yohack.wildg.base.view

import androidx.lifecycle.LifecycleOwner
import cn.yohack.wildg.base.BizException
import cn.yohack.wildg.base.net.data.ResultState

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description loading or toast event for apps in activity or msg
 **/

/**
 * tag show loading
 */
const val TAG_LOADING_SHOW = 1

/**
 * tag hide loading
 */
const val TAG_LOADING_HIDE = 2

/**
 * tag show default empty page
 */
const val TAG_LOADING_ERROR_PAGE = 3


interface ILoadAndToastEvent {


    /**
     * register common viewmodel
     */
    fun registerCommonVm(vm: BaseViewModel) {
        registerLoadingChangeVM(vm)
        registerToastMsgVm(vm)
    }

    /**
     * register loading status
     */
    private fun registerLoadingChangeVM(vm: BaseViewModel) {
        vm.loadingChange.observe(getLOwner(), {
            when (it?.first) {
                TAG_LOADING_SHOW -> showLoading(it.second)
                TAG_LOADING_HIDE -> dismissLoading()
            }
            if (it != null) {
                vm.loadingChange.value = null
            }
        })
    }

    /**
     * register toast status
     */
    private fun registerToastMsgVm(vm: BaseViewModel) {
        vm.toastMsg.observe(getLOwner(), {
            showToast(it)
            if (!it.isNullOrBlank()) {
                vm.toastMsg.value = null
            }
        })
    }

    fun <T> parseState(
        resultState: ResultState<T>,
        onSuccess: (T) -> Unit,
        onError: (BizException) -> Unit = {
            showToast(it.message)
        },
        onLoading: (String) -> Unit? = { showLoading(it) }
    ) {
        when (resultState) {
            is ResultState.Loading -> {
                if (resultState.loadingMsg.isNullOrEmpty().not()) {
                    onLoading(resultState.loadingMsg!!)
                }
            }
            is ResultState.Failure -> {
                onError(resultState.exception)
            }
            is ResultState.Success -> {
                dismissLoading()
                onSuccess(resultState.value)
            }
        }

    }

    /**
     * get LifecycleOwner
     */
    fun getLOwner(): LifecycleOwner

    /**
     * show loading
     */
    fun showLoading(msg: String?)

    /**
     * dismiss loading
     */
    fun dismissLoading()

    /**
     * show toast
     */
    fun showToast(msg: String?)
}