package com.aric.finalweather.extentions

sealed class BooleanExt<out T>

object FalseAny : BooleanExt<Nothing>()
class TrueAny<T>(val data: T) : BooleanExt<T>()

inline fun <T> Boolean.isTrue(block: () -> T) =
    when {
        this -> {
            TrueAny(block())
        }
        else -> FalseAny
    }

inline fun <T> Boolean.isFalse(block: () -> T) = when {
    this -> FalseAny
    else -> {
        TrueAny(block())
    }
}

inline fun <T> BooleanExt<T>.otherwise(block: () -> T): T =
    when (this) {
        is FalseAny -> block()
        is TrueAny -> this.data
    }