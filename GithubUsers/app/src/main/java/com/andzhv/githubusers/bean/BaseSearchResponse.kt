package com.andzhv.githubusers.bean

import com.google.gson.annotations.SerializedName

/**
 * Created by zhaowei on 2021/9/10.
 */
data class BaseSearchResponse<M>(
    @SerializedName("total_count") val totalCount: Int,
    @SerializedName("incomplete_results") var incompleteResults: Boolean,
    @SerializedName("items") var items: List<M>,
)