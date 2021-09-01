package com.wiredcraft.demo.base

import android.content.Intent
import android.os.Bundle
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleObserver
import androidx.lifecycle.OnLifecycleEvent
import io.reactivex.disposables.Disposable

open class BaseViewModel : LifecycleObserver {
    // 页面进入时带入的参数
    var arguments = Bundle()

    var onShownDisposables = mutableListOf<Disposable?>()

    var onCreateDisposables = mutableListOf<Disposable?>()

    private var owner: Lifecycle? = null
    protected val lifecycleObservers = mutableListOf<LifecycleObserver>()

    @OnLifecycleEvent(Lifecycle.Event.ON_CREATE)
    open fun onCreate() {
    }

    /**
     * there isn't [Intent], can still get Intent from [arguments]
     */
    open fun onNewIntent() {}

    open fun onActivityResult(requestCode: Int, data: Intent) {
        lifecycleObservers
            .filterIsInstance<BaseViewModel>()
            .forEach { it.onActivityResult(requestCode, data) }
    }

    @OnLifecycleEvent(Lifecycle.Event.ON_DESTROY)
    open fun onDestroy() {
        owner?.removeObserver(this)
        onCreateDisposables.forEach { it?.dispose() }

        lifecycleObservers.forEach { owner?.removeObserver(it) }
    }

    open fun onBackPress() = true

    open fun onShown() {
        lifecycleObservers.filterIsInstance<BaseViewModel>().forEach { it.onShown() }
    }

    open fun onHidden() {
        onShownDisposables.forEach { it?.dispose() }
        lifecycleObservers.filterIsInstance<BaseViewModel>().forEach { it.onHidden() }
    }

    open fun onBackClick() {
        // TODO: finish current activity.
    }

    fun setLifecycleOwner(owner: Lifecycle) {
        this.owner = owner
        this.owner?.addObserver(this)
    }

    fun addSubViewModel(vararg vms: BaseViewModel) {
        lifecycleObservers.addAll(vms)
        vms.forEach { owner?.addObserver(it) }
    }

    fun arguments(key: String): String {
        return arguments.getString(key) ?: ""
    }

    inline fun <reified T> arguments(key: String): T? {
        return when (T::class) {
            Int::class -> arguments.getInt(key) as? T
            String::class -> arguments.getString(key) as? T
            Boolean::class -> arguments.getBoolean(key) as? T
            else -> arguments.getSerializable(key) as? T
        }
    }
}