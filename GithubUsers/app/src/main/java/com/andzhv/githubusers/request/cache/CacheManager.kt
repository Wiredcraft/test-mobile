package com.andzhv.githubusers.request.cache

import com.andzhv.githubusers.GithubApplication
import com.andzhv.githubusers.utils.ParameterizedTypeImpl
import com.google.gson.Gson
import java.io.File
import java.io.FileOutputStream
import java.io.FileReader

/**
 * Created by zhaowei on 2021/9/11.
 */
object CacheManager {


    fun <T> writeToCache(key: String, id: String, model: T) {
        try {
            val file = getFile(key, id)
            val fos = FileOutputStream(file)
            fos.write(Gson().toJson(model).toByteArray())
            fos.flush()
            fos.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }


    fun <T> readFromCacheList(key: String, id: String, type: Class<T>): List<T>? {
        var data: List<T>? = null
        val file = getFile(key, id)
        try {
            if (file.exists()) {
                val fis = FileReader(file)
                val clazz = ParameterizedTypeImpl(List::class.java, arrayOf(type))
                data = Gson().fromJson<List<T>>(FileReader(file), clazz)
                fis.close()
            }
        } catch (e: Exception) {
            if (file.exists()) {
                file.delete()
            }
            e.printStackTrace()
        }
        return data
    }


    fun getFile(key: String, id: String): File {
        val dir = File(GithubApplication.context.cacheDir.absoluteFile, "request_cache")
        if (!dir.exists() || !dir.isDirectory) {
            dir.mkdir()
        }
        val modelDir = File(dir, key)
        if (!modelDir.exists() || !dir.isDirectory) {
            modelDir.mkdir()
        }
        return File(dir, id)
    }

}
