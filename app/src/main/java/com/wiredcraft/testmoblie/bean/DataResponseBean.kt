package com.wiredcraft.testmoblie.bean

/**
 * 接口返回实体类
 * @author Bruce
 * @date 2020/3/4
 */
data class DataResponseBean<T>(val total_count: Int, val incomplete_results: Boolean, val items: List<T>)