package com.example.testmobile.model

import com.google.gson.annotations.SerializedName

data class SearchUserResponse(
    @SerializedName("total_count")
    val totalCount: Int,
    @SerializedName("incomplete_results")
    val incompleteResults: Boolean,
    val items: List<GithubUser>?,
)