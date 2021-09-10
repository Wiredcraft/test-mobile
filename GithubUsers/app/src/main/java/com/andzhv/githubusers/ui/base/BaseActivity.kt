package com.andzhv.githubusers.ui.base

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.adgvcxz.AFViewModel
import com.adgvcxz.IModel
import io.reactivex.rxjava3.disposables.CompositeDisposable

/**
 * Created by zhaowei on 2021/9/10.
 */
abstract class BaseActivity<V: AFViewModel<M>, M: IModel>: AppCompatActivity() {
    abstract val layoutId: Int
    val disposables: CompositeDisposable by lazy { CompositeDisposable() }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(layoutId)
        initData()
        initView(savedInstanceState)
        initBinding()
    }

    open fun initView(savedInstanceState: Bundle?) {

    }

    open fun initData() {

    }

    open fun initBinding(){

    }

    override fun onDestroy() {
        super.onDestroy()
        disposables.dispose()
    }
}