package com.aric.finalweather.base

import android.annotation.TargetApi
import android.content.Context
import android.os.Build
import android.util.AttributeSet
import android.view.View
import android.view.WindowInsets
import android.widget.FrameLayout

class WindowFrameLayout(context: Context, attributeSet: AttributeSet? = null, defStyle: Int = 0) :
    FrameLayout(context, attributeSet, defStyle) {

    @TargetApi(Build.VERSION_CODES.KITKAT_WATCH)
    override fun addView(child: View?) {
        super.addView(child)
        requestApplyInsets()
    }

    @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    override fun dispatchApplyWindowInsets(insets: WindowInsets?): WindowInsets {
        var windowInsets = super.dispatchApplyWindowInsets(insets)
        if (!insets!!.isConsumed) {
            val count = childCount
            for (i in 0 until count) {
                windowInsets = getChildAt(i).dispatchApplyWindowInsets(insets)
            }
        }
        return windowInsets
    }
}