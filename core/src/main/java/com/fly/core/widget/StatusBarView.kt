package com.fly.core.widget

import android.content.Context
import android.util.AttributeSet
import android.view.View
import com.fly.core.util.Screen
import com.fly.core.util.dp2px

/**
 * created by xdw on 2020.07.14
 * 自定义通用状态栏view 防止不同手机系统状态栏高度不一
 */
class StatusBarView @JvmOverloads constructor(context: Context?, attrs: AttributeSet? = null, defStyleAttr: Int = 0): View(
    context,
    attrs,
    defStyleAttr
) {

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        var height: Int = Screen.getStatusHeight()
        if (height <= 0) {
            height = 20.dp2px()
        }
        super.onMeasure(widthMeasureSpec, MeasureSpec.makeMeasureSpec(height, MeasureSpec.EXACTLY))
    }
}