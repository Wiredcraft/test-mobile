package com.wiredcraft.mobileapp.scope

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: Provides the constructor for ViewModel
 *
 */
class ViewModelScope {

    private var mApplicationProvider: ViewModelProvider? = null


    /**
     * Provides ViewModel constructors at the application level
     * @param modelClass the class type of ViewModel
     */
    fun <T : ViewModel> getApplicationScopeViewModel(modelClass: Class<T>): T {
        if (mApplicationProvider == null) mApplicationProvider = ViewModelProvider(ApplicationInstance)
        return mApplicationProvider!![modelClass]
    }
}