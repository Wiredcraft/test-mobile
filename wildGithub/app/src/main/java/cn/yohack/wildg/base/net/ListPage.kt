package cn.yohack.wildg.base.net

import android.view.View
import androidx.core.view.isVisible
import androidx.lifecycle.MutableLiveData
import cn.yohack.wildg.base.BizException
import cn.yohack.wildg.base.net.data.BaseResponse
import cn.yohack.wildg.base.net.data.PageDTO
import com.chad.library.adapter.base.BaseQuickAdapter

/**
 * @Author yo_hack
 * @Date 2021.12.28
 * @Description 适用于list 相关列表 分理出通用方法
 **/


class ListDataUiState<T>(
    /** 总的 list 数据 **/
    var list: MutableList<T>,
    /** 当前页码 **/
    var page: Int,
    /**下一页**/
    var nextPage: Int,
    /** 是否有更多的数据 **/
    var hasMore: Boolean = false,
    /** 数据总条数 当 total == -1 时 没有条数这个字断 **/
    var total: Int = -LIST_NO_TOTAL,
    /** 上一次的 size 可用于 adapter range 刷新 **/
    var lastSize: Int,
    /** 错误信息 仅出现当 list 为空的时候的错误信息 **/
    var exception: BizException? = null
) {

    fun isFirstPage() = page == COMMON_PAGE_START

    fun isEmpty() = list.size <= 0

}

/**
 * 获取列表信息转换
 * @param page page
 * @param pageSize pSize
 * @param block 请求网络
 * @param data 数据流
 */
suspend fun <T> getList(
    page: Int,
    pageSize: Int,
    data: MutableLiveData<ListDataUiState<T>>,
    block: suspend (Int, Int) -> BaseResponse<PageDTO<T>>
) {
    runCatching {
        block(page, pageSize)
    }.onSuccess {
        if (it.success()) {
            val responseData = it.data
            val responseList = responseData?.items

            if (responseList.isNullOrEmpty()) {
                // 请求返回的数据是 null
                commonFailure(data, page, false, BizException(NET_NO_DATA, ""))
            } else {
                val nextP = page + 1

                val oldList = data.value?.list
                val oldSize = oldList?.size ?: 0

                val newList = mutableListOf<T>()

                // add old list
                if (page != COMMON_PAGE_START && !oldList.isNullOrEmpty()) {
                    newList.addAll(oldList)
                }

                // hasMore
                val hasMore = responseData.hasMore(oldSize)

                // add new list
                newList.addAll(responseList)
                data.postValue(ListDataUiState(newList, page, nextP, hasMore, lastSize = oldSize))
            }
        } else {
            commonFailure(
                data, page, throwable = BizException(it.code, it.msg ?: "")
            )
        }
    }.onFailure {
        commonFailure(data, page, throwable = it)
    }
}

/**
 * 通用的 failure
 */
fun <T> commonFailure(
    data: MutableLiveData<ListDataUiState<T>>,
    page: Int,
    hasMore: Boolean? = null,
    throwable: Throwable
) {
    val total: Int
    val more: Boolean

    // 分页加载中， 获取中间的数据
    val beforeList = if (page == COMMON_PAGE_START) {
        total = 0
        more = false
        mutableListOf()
    } else {
        total = data.value?.total ?: LIST_NO_TOTAL
        more = hasMore ?: data.value?.hasMore ?: false
        data.value?.list ?: mutableListOf()
    }
    data.postValue(
        ListDataUiState(
            beforeList, page, page, more, total, beforeList.size,
            handleNetException(throwable)
        )
    )
}


/**
 * 用于监听 list 数据, adapter 刷新数据， contentView 和 errorView 动态展示互相展示和隐藏, 关闭刷新的效果或者loadMore的效果， 显示 errorView 时需要的操作
 * @param data: list data
 * @param adapter:  adapter extends BasequickAdapter
 * @param contentView: 展示列表的 view
 * @param errorView: page == 1展示 errorView
 * @param finishRefresh: finish refresh 操作
 * @param finishLoadMore finish loadMore
 * @param hasMoreAction: 列表是否有更多的操作
 * @param errorViewBlock: 展示 errorView , 不展示 contentView 时 显示的数据
 */
fun <T> setListObserver(
    data: ListDataUiState<T>,
    adapter: BaseQuickAdapter<T, *>,
    contentView: View?,
    errorView: View?,
    finishRefresh: (() -> Unit)? = null,
    finishLoadMore: ((success: Boolean) -> Unit)? = {
        if (it) {
            adapter.loadMoreModule.loadMoreComplete()
        } else {
            adapter.loadMoreModule.loadMoreEnd()
        }
    },
    hasMoreAction: ((hasMore: Boolean) -> Unit)? = {
        adapter.loadMoreModule.isEnableLoadMore = it
    },
    errorViewBlock: ((code: Int, msg: String) -> Unit)? = { code, msg ->
    }
) {
    var contentVisible = true

    if (data.exception == null && !data.list.isNullOrEmpty()) {
        // 有数据
        adapter.setNewInstance(data.list)

        if (data.isFirstPage()) {
            // 是否是第一页
            finishRefresh?.invoke()
        } else {
            finishLoadMore?.invoke(true)
        }
    } else {
        // 无数据
        if (data.isFirstPage()) {
            // 处于第一页没更多数据
            contentVisible = false
            adapter.setNewInstance(null)
            finishRefresh?.invoke()

            errorViewBlock?.invoke(
                data.exception?.code ?: NET_NO_DATA,
                data.exception?.message ?: ""
            )
        } else {
            adapter.setNewInstance(data.list)
            finishLoadMore?.invoke(false)
        }

    }
    hasMoreAction?.invoke(data.hasMore)
    contentView?.isVisible = contentVisible
    errorView?.isVisible = !contentVisible
}



