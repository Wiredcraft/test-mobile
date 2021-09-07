package com.fly.core.base

import androidx.fragment.app.Fragment
import com.fly.core.widget.LoadingDialog

/**
 * Created by likainian on 2021/7/13
 * Description:  所有页面的父类
 */

abstract class BaseFragment : Fragment(){

    private val mLoadingDialog by lazy {
        LoadingDialog.Builder(requireActivity())
            .setCancelable(false)
            .setCancelOutside(false).create()
    }

    protected fun showLoading() {
        requireActivity().runOnUiThread {
            if (!mLoadingDialog.isShowing) {
                mLoadingDialog.show()
            }
        }
    }

    protected fun hideLoading() {
        requireActivity().runOnUiThread {
            if (mLoadingDialog.isShowing) {
                mLoadingDialog.dismiss()
            }
        }
    }

}