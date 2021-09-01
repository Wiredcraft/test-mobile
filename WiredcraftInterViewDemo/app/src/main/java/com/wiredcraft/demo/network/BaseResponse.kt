package com.wiredcraft.demo.network

import com.google.gson.annotations.SerializedName

open class BaseResponse<T> {
    var items: T? = null

    @SerializedName("total_count")
    val count: Int = 0

    @SerializedName("incomplete_results")
    val incomplete: Boolean = true
}