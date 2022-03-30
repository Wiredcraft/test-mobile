package xyz.mengxy.githubuserslist.model

import com.google.gson.annotations.SerializedName

/**
 * Created by Mengxy on 3/29/22.
 * Data class that represents a repo from GitHub.
 * Not all of the fields returned from the API are represented here; only the ones used in this
 * project are listed below.
 */
data class Repo(
    @SerializedName("id") val repoId: String,
    @SerializedName("name") val repoName: String,
    @SerializedName("stargazers_count") val repoScore: String,
    @SerializedName("html_url") val repoUrl: String,
    @SerializedName("owner") val ownerInfo: User
) : InfoPresenter {
    override fun isUserInfo(): Boolean {
        return false
    }

    override fun getAvatarUrl(): String {
        return ownerInfo.getAvatarUrl()
    }

    override fun getName(): String {
        return repoName
    }

    override fun getScore(): String {
        return repoScore
    }

    override fun getUrl(): String {
        return repoUrl
    }

}
