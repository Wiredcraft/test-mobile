package com.yxf.mvvmcommon.mvvm

import android.os.Bundle
import android.os.PersistableBundle
import androidx.lifecycle.ViewModel
import androidx.viewbinding.ViewBinding
import com.yxf.mvvmcommon.app.BaseActivity
import com.yxf.mvvmcommon.ktx.getViewBinding
import org.koin.androidx.fragment.android.setupKoinFragmentFactory

abstract class BaseVMActivity<VM : ViewModel, VB : ViewBinding> : BaseActivity() {

    protected open val shouldSetupKoin = true

    protected val vb: VB by lazy { getViewBinding() }
    abstract val vm: VM


    override fun onCreate(savedInstanceState: Bundle?) {
        if (shouldSetupKoin) setupKoinFragmentFactory()
        setContentView(vb.root)
        super.onCreate(savedInstanceState)
    }


}