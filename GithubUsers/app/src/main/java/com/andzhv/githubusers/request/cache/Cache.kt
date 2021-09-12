package com.andzhv.githubusers.request.cache

import com.andzhv.githubusers.bean.SimpleUserBean

/**
 * @param key Cache directory name
 * @param unique Cache identifier
 * Created by zhaowei on 2021/9/11.
 */
open class Cache<M : Any>(
    private val key: String,
    private val unique: String,
    private val clazz: Class<M>
) {

    fun readList(): List<M>? {
        return CacheManager.readFromCacheList(key, unique, clazz)
    }

    fun write(list: List<M>) {
        CacheManager.writeToCache(key, unique, list)
    }
}

sealed class SimpleUserCache(unique: String) :
    Cache<SimpleUserBean>("SimpleUserBean", unique, SimpleUserBean::class.java) {
    class DefaultList : SimpleUserCache("List")
}

