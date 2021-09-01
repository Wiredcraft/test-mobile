package com.wiredcraft.demo.base

import android.webkit.WebView
import android.widget.ImageView
import androidx.databinding.BindingAdapter
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.SCROLL_STATE_IDLE
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout

object BindingAdapter {

    @JvmStatic
    @BindingAdapter(
        "app:imageModel",
        "app:imageHolder",
        requireAll = false
    )
    fun ImageView.setImageModel(
        imageModel: Any?,
        imageHolder: Int? = null
    ) {
        when (imageModel) {
            null -> imageHolder?.let { setImageResource(it) }
            is Int -> setImageResource(imageModel)
            is String -> GlideApp.with(context)
                .load(imageModel).error(imageHolder ?: 0).placeholder(imageHolder ?: 0).into(this)
        }
    }

    @JvmStatic
    @BindingAdapter("app:htmlUrl")
    fun WebView.setHtmlUrl(htmlUrl: String?) {
        htmlUrl?.let { loadUrl(htmlUrl) }
    }

    @JvmStatic
    @BindingAdapter(
        "app:isRefreshing",
        "app:onRefreshListener",
        requireAll = false
    )
    fun SwipeRefreshLayout.setOnRefreshListener(
        isRefresh: Boolean?,
        listener: (() -> Unit)?
    ) {
        if (isRefresh != null) isRefreshing = isRefresh
        if (listener != null) setOnRefreshListener { listener() }
    }

    @JvmStatic
    @BindingAdapter("app:onLoadMoreListener")
    fun RecyclerView.setOnLoadMoreListener(
        loadMoreListener: (() -> Unit)?
    ) {
        addOnScrollListener(object : RecyclerView.OnScrollListener() {
            override fun onScrollStateChanged(
                recyclerView: RecyclerView,
                newState: Int
            ) {
                if (newState == SCROLL_STATE_IDLE && !canScrollVertically(1)) {
                    loadMoreListener?.invoke()
                }
            }
        })
    }
}