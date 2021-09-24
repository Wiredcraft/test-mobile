package com.yxf.githubuserlist.ktx

import androidx.lifecycle.MutableLiveData
import com.yxf.githubuserlist.model.UserInfo

fun MutableLiveData<MutableList<UserInfo>>.getLastPage(): Int {
    val infoList = value ?: return -1
    if (infoList.isEmpty()) return -1
    val lastInfo = infoList[infoList.size - 1]
    return lastInfo.page
}

fun <T> MutableLiveData<T>.requireValue(): T {
    return value!!
}