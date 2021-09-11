package com.caizhixng.githubapidemo

/**
 * czx 2021/9/11
 */
data class Page(var page: Int, val perPage: Int, var keyWord: String) {

    fun addPage() {
        page++
    }

    fun restPage() {
        page = 1
    }

}