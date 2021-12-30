package cn.yohack.wildg.utils

import java.lang.reflect.InvocationHandler
import java.lang.reflect.Proxy

/**
 * @Author yo_hack
 * @Date 2021.12.29
 * @Description
 **/
/**
 *  no op delegate
 *  for most cases, we only want implements fewer functions of interfaces
 */
inline fun <reified T : Any> noOpDelegate(): T {
    val javaClass = T::class.java
    val noDelegate = InvocationHandler { _, _, _ -> }
    return Proxy.newProxyInstance(
        javaClass.classLoader, arrayOf(javaClass), noDelegate
    ) as T
}