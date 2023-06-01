package com.aric.finalweather.extentions

import android.text.Editable

sealed class NullableAnyExt<out R>

object NullAny : NullableAnyExt<Nothing>()
class NotNullAny<R>(val data: R) : NullableAnyExt<R>()

inline fun <T, R> T?.notNull(block: (T) -> R) =
    this?.let {
        NotNullAny(block(this))
    } ?: let {
        NullAny
    }

inline fun <T, R> T?.isNull(block: () -> R) =
    this?.let {
        NotNullAny(block())
    } ?: let {
        NullAny
    }

inline fun <R> NullableAnyExt<R>.otherwise(block: () -> R): R = when (this) {
    is NullAny -> block()
    is NotNullAny -> this.data
}

val Any.TAG: String
    get() {
        val tag = javaClass.simpleName
        return if (tag.length <= 23) tag else tag.substring(0, 23)
    }


class TextWatcher(
    var beforeTextChanged: (
        text: CharSequence?,
        start: Int,
        count: Int,
        after: Int
    ) -> Unit = { _, _, _, _ -> },
    var onTextChanged: (
        text: CharSequence?,
        start: Int,
        count: Int,
        after: Int
    ) -> Unit = { _, _, _, _ -> },
    var afterTextChanged: (text: Editable?) -> Unit = {}
)

fun textWatcher(init: TextWatcher.() -> Unit): TextWatcher = TextWatcher().apply(init)

 fun Any?.toStringExt(): String{
     this.notNull {
         return this.toString()
     }.otherwise {
         return  ""
     }
 }

