package xyz.mengxy.githubuserslist.model

import com.google.gson.annotations.SerializedName

/**
 * Created by Mengxy on 3/29/22.
 * Data class that represents a user search response from GitHub.
 */
data class UserSearchResponse(
    @SerializedName("total_count") val totalCount: Int,
    @SerializedName("items") val userList: List<User>
)
