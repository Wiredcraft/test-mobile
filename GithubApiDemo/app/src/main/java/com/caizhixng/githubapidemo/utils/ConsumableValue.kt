package com.caizhixng.githubapidemo.utils

/**
 * czx 2021/9/11
 * https://stackoverflow.com/a/56917825/9895852
 */

class ConsumableValue<T>(private val data: T) {

    private var consumed = false

    fun consume(block: ConsumableValue<T>.(T) -> Unit) {
        if (!consumed) {
            consumed = true
            block(data)
        }
    }
}