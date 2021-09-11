package com.caizhixng.githubapidemo

import android.content.Context

/**
 * Created by caizhixing on 2020/4/7
 */
object SharedPreferencesManager {

    private const val KEYWORD = "keyWord"

    var keyWord: String
        get() {
            return get(KEYWORD, KEYWORD, "caizhixing")
        }
        set(value) {
            put(KEYWORD, KEYWORD, value)
        }

    private inline fun <reified T> put(name: String, key: String, value: T) {
        val sp = App.app.getSharedPreferences(name, Context.MODE_PRIVATE).edit()
        when (value) {
            is String -> sp.putString(key, value)
            is Int -> sp.putInt(key, value)
            is Boolean -> sp.putBoolean(key, value)
            is Long -> sp.putLong(key, value)
        }
        sp.apply()
    }

    private inline fun <reified T> get(name: String, key: String, defaultValue: T): T {
        val sp = App.app.getSharedPreferences(name, Context.MODE_PRIVATE)
        val result = when (defaultValue) {
            is String -> sp.getString(key, defaultValue)
            is Int -> sp.getInt(key, defaultValue)
            is Boolean -> sp.getBoolean(key, defaultValue)
            is Long -> sp.getLong(key, defaultValue)
            else -> ""
        }
        return result as T
    }

}