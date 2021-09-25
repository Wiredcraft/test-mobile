package com.yxf.githubuserlist.model.bean

import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass

data class HttpResult<T>(
    val data: T
)

@JsonClass(generateAdapter = true)
data class PageDetail(
    @Json(name = "total_count")
    val totalCount: Int,
    @Json(name = "incomplete_results")
    val incompleteResults: Boolean,
    @Json(name = "items")
    val userDetailList: MutableList<UserDetail>
)

@JsonClass(generateAdapter = true)
data class UserDetail(
    val login: String,
    val id: Long,
    @Json(name = "node_id")
    val nodeId: String,
    @Json(name = "avatar_url")
    val avatarUrl: String,
    @Json(name = "html_url")
    val htmlUrl: String,
    val score: Float
)