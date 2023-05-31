package com.wiredcraft.mobileapp.domain

/**
 *
 */
const val SYSTEM_ERROR_CODE = 1

class AppException(
    var errCode: Int = 0,
    error: String?
) : Exception(error) {
    var errorMsg = error ?: "请求失败，请稍后再试"
}