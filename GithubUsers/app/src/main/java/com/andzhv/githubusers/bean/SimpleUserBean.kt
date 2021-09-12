package com.andzhv.githubusers.bean

import com.google.gson.annotations.SerializedName

/**
 * Created by zhaowei on 2021/9/11.
 */
data class SimpleUserBean(
    @SerializedName("id") val id: Long,
    @SerializedName("login") val login: String,
    @SerializedName("avatar_url") val avatarUrl: String,
    @SerializedName("score") val score: Float,
    @SerializedName("html_url") val htmlUrl: String,
    @SerializedName("url") val url: String
)