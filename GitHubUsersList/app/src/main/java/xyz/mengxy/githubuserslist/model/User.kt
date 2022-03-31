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
) : InfoPresenter {

    var isFollowed = false

    override fun isUserFollowed(): Boolean {
        return isFollowed
    }

    override fun isUserInfo(): Boolean {
        return true
    }

    override fun getAvatarUrl(): String {
        return userAvatar
    }

    override fun getName(): String {
        return userName
    }

    override fun getScore(): String {
        return userScore ?: "0"
    }

    override fun getUrl(): String {
        return userUrl
    }

    override fun equals(other: Any?): Boolean {
        return (other as? User)?.userId == userId
    }

    override fun hashCode(): Int {
        var result = userId.hashCode()
        result = 31 * result + userName.hashCode()
        return result
    }
}
