package com.fly.audio.model

/**
 * Created by likainian on 2021/8/31
 * Description:
 */

data class PageBean<T>(
    val total_count:Int,
    val items:ArrayList<T>
)