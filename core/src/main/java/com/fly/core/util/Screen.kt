package com.fly.core.util

import android.content.Context
import android.util.DisplayMetrics
import android.view.WindowManager
import com.fly.core.base.appContext

/**
 * Created by likainian on 2021/7/13
 * Description:  屏幕的宽高
 */

object Screen {

    /**
     * 屏幕宽度
     */
    var width = 0
        private set
    /**
     * 屏幕高度
     */
    var height = 0
        private set
    /**
     * 屏幕真实宽度
     */
    var realWidth = 0 // 屏幕物理宽度
        private set
    /**
     * 屏幕真实高度
     */
    var realHeight = 0 // 屏幕物理高度
        private set

    init {
        val wm = appContext.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val display = wm.defaultDisplay
        val metrics = DisplayMetrics()
        //获取当前屏幕的使用高度
        display?.getMetrics(metrics)
        width = metrics.widthPixels
        height = metrics.heightPixels

        val realMetrics = DisplayMetrics()
        //可能有虚拟按键的情况
        display?.getRealMetrics(realMetrics)
        realWidth = realMetrics.widthPixels
        realHeight = realMetrics.heightPixels
    }

    /**
     * 获得状态栏的高度
     */
    fun getStatusHeight(): Int {
        var result = 0
        val resourceId: Int = appContext.resources
            .getIdentifier("status_bar_height", "dimen", "android")
        if (resourceId > 0) {
            result = appContext.resources.getDimensionPixelSize(resourceId)
        }
        return result
    }

    /**
     * 非全面屏下 虚拟键高度(无论是否隐藏)
     */
    fun getNavigationBarHeight(): Int {
        var result = 0
        val resourceId: Int = appContext.resources
            .getIdentifier("navigation_bar_height", "dimen", "android")
        if (resourceId > 0) {
            result = appContext.resources.getDimensionPixelSize(resourceId)
        }
        return result
    }

    fun hasVirtualBar() = height != realHeight
}