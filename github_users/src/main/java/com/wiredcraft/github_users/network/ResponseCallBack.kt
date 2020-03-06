package com.wiredcraft.testmoblie.network

import okhttp3.Response

/**
 * 网络请求回调接口
 * @author Bruce
 * @date 2020/3/4
 */
interface ResponseCallBack {
    fun onFailure(e: Throwable)

    fun onSuccess(response: Response)
}