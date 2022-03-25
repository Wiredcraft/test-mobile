package com.wiredcraft.example

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.gyf.immersionbar.ImmersionBar
import android.os.Build
import android.app.AlertDialog
import android.app.TabActivity
import androidx.core.app.ActivityCompat
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat
import kotlin.jvm.JvmOverloads
import androidx.annotation.StringRes
import android.os.Handler
import com.blankj.utilcode.util.AppUtils
import android.os.Looper
import android.util.Log
import com.wiredcraft.example.widget.CustomLoadMoreView
import java.util.*

/**
 * @author 武玉朋
 */
abstract class BaseActivity : AppCompatActivity() {
    val TAG = javaClass.simpleName

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.d("ActivityLog", this.javaClass.simpleName)
    }

    /**
     * @param dark 状态栏字体颜色
     */
    protected fun initView(dark: Boolean) {

        ImmersionBar.with(this).barAlpha(0.0f).statusBarDarkFont(dark).init()

        initActionBar()
        initWidget()
        initListener()
    }

    /**
     * 初始化控件和控件状态
     */
    protected abstract fun initActionBar()

    /**
     * 初始化控件和控件状态
     */
    protected abstract fun initWidget()

    /**
     * 设置监听事件
     */
    protected abstract fun initListener()
}