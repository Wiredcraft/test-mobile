package com.wiredcraft.testmoblie.bean

data class SearchUsersResponse(val total_count: Int, val incomplete_results: Boolean, val items: ArrayList<UserBean>)