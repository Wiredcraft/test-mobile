package com.wiredcraft.githubuser.base

import android.graphics.Color
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity

abstract class BaseActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(setLayoutId())
        setStatusBar()
    }

    abstract fun setLayoutId(): Int

    /**
     * 是否预留出状态栏高度
     */
    protected open fun isPadding(): Boolean = true

    /**
     * 设置状态栏颜色
     */
    protected open fun setStatusBarColor(): Int = Color.TRANSPARENT

    /**
     * 是否设置状态栏字体颜色为暗色
     */
    protected open fun isDark(): Boolean = true

    private fun setStatusBar(
        color: Int = setStatusBarColor(),
        dark: Boolean = isDark(),
        isPadding: Boolean = isPadding()
    ) {
        window.statusBarColor = color
        window.decorView.systemUiVisibility =
            View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or View.SYSTEM_UI_FLAG_LAYOUT_STABLE or if (dark) View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR else 0
        window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)

        if (isPadding) {
            val rootView: ViewGroup =
                window.decorView.findViewById(android.R.id.content) as ViewGroup
            rootView.setPadding(0, getStatusBarHeight(), 0, 0)
        }
    }

    private fun getStatusBarHeight(): Int {
        var result = 0
        val resourceId = resources.getIdentifier("status_bar_height", "dimen", "android")
        if (resourceId > 0) {
            result = resources.getDimensionPixelSize(resourceId)
        }
        return result
    }
}