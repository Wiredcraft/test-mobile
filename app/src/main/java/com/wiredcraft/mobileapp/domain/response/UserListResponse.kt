package com.wiredcraft.mobileapp.domain.response

import com.google.gson.annotations.SerializedName

data class UserListResponse(
    @SerializedName("total_count") val totalCount: Long,
    @SerializedName("incomplete_results") val incompleteResults: Boolean,
    val items: List<UserInfo>?
)

data class UserInfo(
    @SerializedName("gists_url") val gistsURL: String,
    @SerializedName("repos_url") val reposURL: String,
    @SerializedName("following_url") val followingURL: String,
    @SerializedName("starred_url") val starredURL: String,
    @SerializedName("login") val login: String,
    @SerializedName("followers_url") val followersURL: String,
    @SerializedName("type") val type: Type,
    @SerializedName("url") val url: String,
    @SerializedName("subscriptions_url") val subscriptionsURL: String,
    @SerializedName("score") val score: Long,
    @SerializedName("received_events_url") val receivedEventsURL: String,
    @SerializedName("avatar_url") val avatarURL: String,
    @SerializedName("events_url") val eventsURL: String,
    @SerializedName("html_url") val htmlURL: String,
    @SerializedName("site_admin") val siteAdmin: Boolean,
    @SerializedName("id") val id: Long,
    @SerializedName("gravatar_id") val gravatarID: String,
    @SerializedName("node_id") val nodeID: String,
    @SerializedName("organizations_url") val organizationsURL: String
)

enum class Type {
    Organization,
    User
}
