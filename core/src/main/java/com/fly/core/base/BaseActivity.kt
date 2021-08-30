package com.fly.core.base

import androidx.appcompat.app.AppCompatActivity
import com.fly.core.widget.LoadingDialog

/**
 * Created by likainian on 2021/7/13
 * Description:  所有页面的父类
 */

abstract class BaseActivity : AppCompatActivity(){

    private val mLoadingDialog by lazy {
        LoadingDialog.Builder(this)
            .setCancelable(false)
            .setCancelOutside(false).create()
    }

    protected fun showLoading() {
        runOnUiThread {
            if (!mLoadingDialog.isShowing) {
                mLoadingDialog.show()
            }
        }
    }

    protected fun hideLoading() {
        runOnUiThread {
            if (mLoadingDialog.isShowing) {
                mLoadingDialog.dismiss()
            }
        }
    }
}