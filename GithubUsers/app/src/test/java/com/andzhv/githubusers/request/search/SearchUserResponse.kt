package com.andzhv.githubusers.request.search

/**
 * Created by zhaowei on 2021/9/13.
 */
sealed interface SearchUserResponse {
    object Failure : SearchUserResponse
    data class Success(val inCompleted: Boolean, val size: Int) : SearchUserResponse
}