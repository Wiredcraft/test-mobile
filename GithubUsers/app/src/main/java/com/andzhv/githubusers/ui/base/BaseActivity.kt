package com.andzhv.githubusers.ui.base

import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.viewbinding.ViewBinding
import com.adgvcxz.AFViewModel
import com.adgvcxz.IModel
import com.adgvcxz.IViewModel
import com.adgvcxz.addTo
import io.reactivex.rxjava3.disposables.CompositeDisposable

/**
 * Created by zhaowei on 2021/9/10.
 */
abstract class BaseActivity<V : IViewModel<M>, M : IModel> : AppCompatActivity() {

    abstract val layoutId: Int

    abstract val viewModel: V

    val disposables: CompositeDisposable by lazy { CompositeDisposable() }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(layoutId)
        initData()
        initView(savedInstanceState)
        viewModel.model.subscribe().addTo(disposables)
        initBinding()
    }

    open fun initView(savedInstanceState: Bundle?) {

    }

    open fun initData() {

    }

    open fun initBinding() {

    }

    override fun onDestroy() {
        super.onDestroy()
        disposables.dispose()
    }

    fun <T : ViewBinding> generateViewBinding(bind: (View) -> T): Lazy<T> {
        return lazy(LazyThreadSafetyMode.NONE) {
            bind(findViewById<ViewGroup>(android.R.id.content).getChildAt(0))
        }
    }
}