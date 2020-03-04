package com.wiredcraft.testmoblie.bean

/**
 * 接口返回实体类
 * @author Bruce
 * @date 2020/3/4
 */
data class DataResponseBean<T>(val total_count: Int,
                               val incomplete_results: Boolean,
                               val items: ArrayList<T>,
                               val message: String,
                               val errors: ArrayList<ErrorBean>,
                               val documentation_url: String)