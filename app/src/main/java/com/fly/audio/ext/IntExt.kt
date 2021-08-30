package com.fly.audio.ext

import java.math.BigDecimal
import java.math.RoundingMode
import java.text.DecimalFormat

const val INVALID = -999

fun Int.isValid(): Boolean = this != INVALID

fun Int.toDistanceString(): String {
    return when {
        this == 0 -> {
            ""
        }

        this in 0..100 -> {
            "<".append("100").append("m")
        }

        this in 100..999 -> {
            this.toString().append("m")
        }

        this in 1000..999000 -> {
            val result = this.toBigDecimal().divide(1000.toBigDecimal(), 1, RoundingMode.DOWN)
            toStringDropDecimalZero(result).append("km")
        }

        this > 999000 -> {
            ">999km"
        }
        else -> ""
    }
}

fun Int.toNumberAbbreviationString(displayZero: Boolean = false): String {
    if (displayZero && this == 0) {
        return "0"
    } else {
        return when {
            this in 1..999 -> {
                this.toString()
            }

            this in 1_000..999_999 -> {
                val result = this.toBigDecimal().divide(1000.toBigDecimal(), 1, RoundingMode.DOWN)
                toStringDropDecimalZero(result).append("k")
            }

            this > 999_999 -> {
                val result = this.toBigDecimal().divide(1000_000.toBigDecimal(), 1, RoundingMode.DOWN)
                toStringDropDecimalZero(result).append("m")
            }

            else -> ""
        }
    }
}

private fun toStringDropDecimalZero(b: BigDecimal): String {
    val intPart = b.toInt()
    val decimalPart = b - intPart.toBigDecimal()
    return if (decimalPart == 0.0.toBigDecimal()) {
        intPart.toString()
    } else {
        b.toString()
    }
}

fun Int.formatDecimal(): String {
    val df = DecimalFormat("###,###,###,###,###,###")
    return df.format(this)
}
