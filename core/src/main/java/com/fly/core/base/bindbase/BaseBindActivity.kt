package com.fly.core.base.bindbase


import android.os.Bundle
import androidx.databinding.ViewDataBinding
import com.fly.core.base.BaseActivity
/**
 * Created by likainian on 2021/7/13
 * Description:  bind的基类
 */

abstract class BaseBindActivity<K : ViewDataBinding> : BaseActivity() {

    protected lateinit var mViewDataBinding: K

    abstract fun createBinding(): K

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mViewDataBinding = createBinding()
        mViewDataBinding.lifecycleOwner = this
        setContentView(mViewDataBinding.root)

        initView()

        initData()

        registerObserver()
    }

    open fun initView(){

    }

    open fun initData(){

    }

    open fun registerObserver(){

    }
}