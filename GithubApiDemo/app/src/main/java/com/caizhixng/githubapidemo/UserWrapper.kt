package com.caizhixng.githubapidemo

import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
data class UserWrapper(
    @SerializedName("items")
    val userList: List<User>,
    @SerializedName("total_count")
    val totalCount: Int
)

@Keep
data class User(
    @SerializedName("avatar_url")
    val userUrl: String,
    @SerializedName("login")
    val userName: String,
    @SerializedName("score")
    val userScore: String
)