package com.fly.core.base.bindbase

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.CallSuper
import androidx.databinding.ViewDataBinding
import com.fly.core.base.BaseFragment

/**
 * Created by likainian on 2021/7/13
 * Description:  bind的基类
 */

abstract class BaseBindFragment<K : ViewDataBinding> : BaseFragment() {

    protected lateinit var mViewDataBinding: K

    abstract fun createBinding(): K

    @CallSuper
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        mViewDataBinding = createBinding()
        mViewDataBinding.lifecycleOwner = this
        return mViewDataBinding.root
    }

    @CallSuper
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        initView(view)

        initData()

        registerObserver()
    }

    open fun initView(view: View) {
    }

    open fun initData() {
    }

    open fun registerObserver() {
    }
}