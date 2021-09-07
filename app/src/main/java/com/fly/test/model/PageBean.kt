package com.fly.test.model

/**
 * Created by likainian on 2021/8/31
 * Description: 分页的泛型
 */

data class PageBean<T>(
    val total_count:Int,
    val items:ArrayList<T>
)