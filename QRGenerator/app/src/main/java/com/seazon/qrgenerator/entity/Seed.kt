package com.seazon.qrgenerator.entity

import okhttp3.ResponseBody

/**
 * Created by seazon on 2018/3/8.
 */
data class Seed(val seed: String, val expires_at: String, val expires_at_long: Long) {
}