package com.wiredcraft.demo.base

import androidx.annotation.CallSuper
import androidx.databinding.ObservableBoolean
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers

/**
 * @author hs on 5/17/21
 * 适用于页面为 recyclerView
 */
abstract class BasePagingViewModel : BaseViewModel() {

    var pageNum = 1
    var pageSize = 10
    var canLoadMore = false

    val isRefreshing = ObservableBoolean()
    val showEmptyView = ObservableBoolean(false)

    abstract fun fetchData()

    override fun onShown() {
        super.onShown()
        pageNum = 1
    }

    @CallSuper
    open fun onRefresh() {
        pageNum = 1
        isRefreshing.set(true)
        fetchData()

        lifecycleObservers.filterIsInstance<BasePagingViewModel>().forEach { it.onRefresh() }
    }

    @CallSuper
    open fun onLoadMore() {
        if (canLoadMore) {
            pageNum++
            fetchData()
        }
    }

    /**
     * 当网络请求发生Error时，是否显示占位图
     * 当第一次加载成功，[onRefresh]或者[onShown]的时候发生Error，需要根据页面是否有数据判断
     */
    open fun showEmptyViewWhenError() = true

    /**
     * 对分页加载结果进行处理
     * 1、结束刷新
     * 2、判断是否能继续加载更多
     */
    inline fun <reified T> Observable<List<T>>.handlePagingResult(): Observable<List<T>> {
        return observeOn(AndroidSchedulers.mainThread())
            .doOnNext {
                isRefreshing.set(false)
                canLoadMore = it.size >= pageSize
                showEmptyView.set(it.isEmpty() && pageNum == 1)
            }
            .doOnError {
                canLoadMore = false
                isRefreshing.set(false)
                showEmptyView.set(pageNum == 1 && showEmptyViewWhenError())
            }
    }
}