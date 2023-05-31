package com.wiredcraft.mobileapp.bean

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: the datasource for userDetail item
 *
 */
data class RepositoryBean(
    val identifyId: Long,
    val repositoryName: String?,
    val avatarUrl: String?,
    val score: Long,
    val url: String?
)