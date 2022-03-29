package xyz.mengxy.githubuserslist.model

import com.google.gson.annotations.SerializedName

/**
 * Created by Mengxy on 3/29/22.
 * Data class that represents a user from GitHub.
 * Not all of the fields returned from the API are represented here; only the ones used in this
 * project are listed below.
 */
data class User(
    @SerializedName("id") val userId: String,
    @SerializedName("login") val userName: String,
    @SerializedName("avatar_url") val userAvatar: String,
    @SerializedName("html_url") val userUrl: String,
    @SerializedName("score") val userScore: String?
)
