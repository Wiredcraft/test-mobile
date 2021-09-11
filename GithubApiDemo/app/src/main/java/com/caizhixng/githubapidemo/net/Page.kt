package com.caizhixng.githubapidemo.net

/**
 * czx 2021/9/11
 */
data class Page(var page: Int, val perPage: Int, var keyWord: String) {

    private val startPage = 1

    fun addPage() {
        page++
    }

    fun isFirstPage() = page == startPage

    fun restPage() {
        page = startPage
    }

}