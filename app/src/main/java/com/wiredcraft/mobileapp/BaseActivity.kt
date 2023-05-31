package com.wiredcraft.mobileapp

import android.os.Bundle
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.ViewModel
import androidx.viewbinding.ViewBinding
import com.gyf.immersionbar.ImmersionBar
import com.wiredcraft.mobileapp.scope.ViewModelScope

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: simple baseActivity for all of activity in project
 * it's provide viewBinding and control the systemUI
 *
 */
abstract class BaseActivity<VB : ViewBinding> : FragmentActivity() {

    protected lateinit var mViewBinding: VB

    private val mViewModelScope = ViewModelScope()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mViewBinding = findViewBinding() as VB
        setContentView(mViewBinding.root)
        if (isImmersionBarEnabled()) {
            ImmersionBar.with(this).init()
        }
    }

    /**
     * Page view, provided by subclasses
     * @return UI layout
     */
    abstract fun findViewBinding(): ViewBinding

    /**
     * Immersion switch
     */
    open fun isImmersionBarEnabled() = true

    protected fun <T : ViewModel> getApplicationScopeViewModel(modelClass: Class<T>): T {
        return mViewModelScope.getApplicationScopeViewModel(modelClass)
    }
}