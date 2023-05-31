package com.wiredcraft.mobileapp.shareviewmodel

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: ViewModel for data sharing only
 */
class ShareViewModel: ViewModel() {

    /**
     * share the identifyId between HomePage and UserDetailPage
     */
    val followUser = MutableLiveData<Long>()
}