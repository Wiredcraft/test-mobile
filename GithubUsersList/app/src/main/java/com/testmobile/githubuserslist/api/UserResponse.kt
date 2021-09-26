package com.testmobile.githubuserslist.api

import com.google.gson.annotations.SerializedName
import com.testmobile.githubuserslist.model.User

/*
* holds the response object that is returned
* by the server
* */
class UserResponse(
  // total counts of items returend
  @SerializedName("total_count") val totalCount: Int = 0,
  // list of users returned
  @SerializedName("items") val results: List<User> = emptyList(),
)