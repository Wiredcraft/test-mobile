package com.yxf.mvvmcommon.mvvm

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModel
import androidx.viewbinding.ViewBinding
import com.yxf.mvvmcommon.ktx.getViewBinding

open class BaseVMFragment<VM : ViewModel, VB : ViewBinding> : Fragment() {

    protected val vb: VB by lazy { getViewBinding() }
    protected val vm: VM by lazy { (requireActivity() as BaseVMActivity<VM, VB>).vm }


    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return vb.root
    }

}