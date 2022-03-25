package com.wiredcraft.example.entity

import com.google.gson.annotations.SerializedName
import java.io.Serializable

class UserResponse:Serializable {
    @SerializedName("total_count")
    var totalCount: Int? = null

    @SerializedName("incomplete_results")
    var isIncompleteResults: Boolean? = null

    @SerializedName("items")
    var items: MutableList<User>? = null
}