package com.wiredcraft.mobileapp.bean

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: datasource for home item UI
 *
 */
data class UserBean(
    val identifyId: Long,
    val avatarUrl: String?,
    val userName: String?,
    val url: String?,
    val score: Long,
    var isFollowed: Boolean = false
)