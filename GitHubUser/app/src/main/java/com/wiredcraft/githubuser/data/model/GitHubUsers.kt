package com.wiredcraft.githubuser.data.model

data class GitHubUsers(
    var incomplete_results: Boolean,
    var items: ArrayList<Item> = arrayListOf(),
    var total_count: Int = 0
)

data class Item(
    var login: String,
    var id: Int,
    var node_id: String,
    var avatar_url: String,
    var gravatar_id: String,
    var url: String,
    var html_url: String,
    var followers_url: String,
    var following_url: String,
    var gists_url: String,
    var starred_url: String,
    var subscriptions_url: String,
    var organizations_url: String,
    var repos_url: String,
    var events_url: String,
    var received_events_url: String,
    var type: String,
    var site_admin: Boolean,
    var score: Double,
    var isFollow: Boolean = false
)