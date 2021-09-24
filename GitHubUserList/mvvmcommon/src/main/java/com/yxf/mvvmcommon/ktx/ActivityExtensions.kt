package com.yxf.mvvmcommon.ktx

import android.app.Activity
import androidx.fragment.app.Fragment
import androidx.viewbinding.ViewBinding
import com.yxf.mvvmcommon.utils.BindingReflex


fun <V : ViewBinding> Activity.getViewBinding(): V {
    return BindingReflex.reflexViewBinding(javaClass, layoutInflater)
}

fun <V : ViewBinding> Fragment.getViewBinding(): V {
    return BindingReflex.reflexViewBinding(javaClass, layoutInflater)
}
