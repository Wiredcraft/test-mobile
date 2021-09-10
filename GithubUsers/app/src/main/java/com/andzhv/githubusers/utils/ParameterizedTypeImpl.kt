package com.andzhv.githubusers.utils

import java.lang.reflect.ParameterizedType
import java.lang.reflect.Type

/**
 * Created by zhaowei on 2021/9/11.
 */
class ParameterizedTypeImpl(private val raw: Class<*>, var args: Array<Type>) : ParameterizedType {


    override fun getRawType(): Type {
        return raw
    }

    override fun getOwnerType(): Type? {
        return null
    }

    override fun getActualTypeArguments(): Array<Type> {
        return args
    }

}