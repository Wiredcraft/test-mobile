package com.fly.audio

import com.fly.audio.ext.toDistanceString
import com.fly.audio.ext.toNumberAbbreviationString
import org.junit.Assert.assertEquals
import org.junit.Test

class IntExtTest {
    @Test
    fun when_meter_is_less_than_100_return_less_symbol_meter_m() {
        val meter = 35
        assertEquals("<100m", meter.toDistanceString())
    }

    @Test
    fun when_meter_is_in_100_to_999_return_meter_m() {
        val meter = 378
        assertEquals("378m", meter.toDistanceString())
    }

    @Test
    fun when_meter_is_in_1000_to_999999_return_meter_km() {
        val meter = 67899
        assertEquals("67.8km", meter.toDistanceString())

        val meter1 = 890000
        assertEquals("890km", meter1.toDistanceString())
    }

    @Test
    fun when_meter_is_more_than_999999_return_more_symbol_meter_km() {
        val meter = 123456789
        assertEquals(">999km", meter.toDistanceString())

        val meter2 = 999001
        assertEquals(">999km", meter2.toDistanceString())

        val meter3 = 999999
        assertEquals(">999km", meter3.toDistanceString())

        val meter4 = 1999999
        assertEquals(">999km", meter4.toDistanceString())
    }

    @Test
    fun when_meter_is_negative_return_blank() {
        val meter = -12
        assertEquals("", meter.toDistanceString())
    }

    @Test
    fun when_number_is_0_return_empty() {
        val number = 0
        assertEquals("", number.toNumberAbbreviationString())
    }

    @Test
    fun when_number_is_less_than_or_equal_to_1000_return_number() {
        val number = 999
        assertEquals("999", number.toNumberAbbreviationString())
    }

    @Test
    fun when_number_is_in_1000_to_999999_return_number_dot_k() {
        val number1 = 999999
        val number2 = 1000
        val number3 = 45678
        val number4 = 78000
        assertEquals("999.9k", number1.toNumberAbbreviationString())
        assertEquals("1k", number2.toNumberAbbreviationString())
        assertEquals("45.6k", number3.toNumberAbbreviationString())
        assertEquals("78k", number4.toNumberAbbreviationString())
    }

    @Test
    fun when_number_is_more_than_999999_return_number_dot_m() {
        val n1 = 14000000
        val n2 = 556789098
        val n3 = 80000000
        assertEquals("14m", n1.toNumberAbbreviationString())
        assertEquals("556.7m", n2.toNumberAbbreviationString())
        assertEquals("80m", n3.toNumberAbbreviationString())
    }
}
