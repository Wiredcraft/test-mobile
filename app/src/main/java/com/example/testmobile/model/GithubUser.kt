package com.example.testmobile.model

import android.os.Parcelable
import com.google.gson.annotations.SerializedName
import kotlinx.parcelize.Parcelize

@Parcelize
data class GithubUser(
    val id: String,
    @SerializedName("avatar_url")
    val avatarUrl: String,
    @SerializedName("login")
    val name: String,
    val score: String,
    @SerializedName("html_url")
    val htmlUrl: String,
) : Parcelable