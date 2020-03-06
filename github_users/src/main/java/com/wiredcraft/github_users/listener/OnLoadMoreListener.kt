package com.wiredcraft.testmoblie.listener

import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import android.support.v7.widget.RecyclerView.SCROLL_STATE_DRAGGING
import android.support.v7.widget.RecyclerView.SCROLL_STATE_SETTLING


/**
 * 上拉加载更多监听
 * @author Bruce
 * @date 2020/3/5
 */
abstract class OnLoadMoreListener: RecyclerView.OnScrollListener() {
    private var itemCount = 0//item总数
    private var lastVisibleItem = 0//最后一个可见item的位置
    private var isScrolled = false //是否在滑动
    private var layoutManager : LinearLayoutManager? = null

    abstract fun onLoadMore()

    override fun onScrollStateChanged(recyclerView: RecyclerView, newState: Int) {
        //SCROLL_STATE_DRAGGING状态代表RecyclerView正在拖拽滑动中
        //SCROLL_STATE_SETTLING状态代表RecyclerView正在惯性滑动中
        //所以当状态为这两个的其中一个时，isScrolled就赋值为true,否则为false
        isScrolled = newState == SCROLL_STATE_DRAGGING || newState == SCROLL_STATE_SETTLING
    }

    override fun onScrolled(recyclerView: RecyclerView, dx: Int, dy: Int) {
        if (recyclerView.layoutManager is LinearLayoutManager) {
            layoutManager = recyclerView.layoutManager as LinearLayoutManager
            itemCount = layoutManager!!.itemCount //获取item的总数
            lastVisibleItem = layoutManager!!.findLastCompletelyVisibleItemPosition()//获取屏幕中最后一个完全可见item的位置
        }

        //RecyclerView在滑动中，且屏幕中最后一个可见的item就是所有item的最后一个，则调用加载更多的方法
        if (isScrolled && lastVisibleItem == itemCount - 1){
            onLoadMore()
        }
    }
}