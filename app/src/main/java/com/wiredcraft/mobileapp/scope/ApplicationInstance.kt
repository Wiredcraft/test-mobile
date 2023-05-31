package com.wiredcraft.mobileapp.scope

import androidx.lifecycle.ViewModelStore
import androidx.lifecycle.ViewModelStoreOwner

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: This object allows you to construct a lifecycle ViewModel at the application level
 *
 */
object ApplicationInstance: ViewModelStoreOwner {

    private var mAppViewModelStore: ViewModelStore = ViewModelStore()

    override val viewModelStore: ViewModelStore
        get() = mAppViewModelStore
}