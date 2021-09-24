package com.yxf.mvvmcommon.app

import android.os.Bundle
import android.os.PersistableBundle
import androidx.appcompat.app.AppCompatActivity

abstract class BaseActivity : AppCompatActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initData()
        initView(savedInstanceState)
    }

    @Deprecated("it may be would not be called", level = DeprecationLevel.ERROR)
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
    }

    abstract fun initData()

    abstract fun initView(savedInstanceState: Bundle?)


    override fun onDestroy() {
        super.onDestroy()
    }


}