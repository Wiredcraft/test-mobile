package com.caizhixng.githubapidemo

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

/**
 * czx 2021/9/11
 */
open class BaseActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initView()
        registerObserver()
        registerListener()
    }

    open fun initView() {}
    open fun registerListener() {}
    open fun registerObserver() {}

}