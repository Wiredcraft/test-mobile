package com.dorck.githuber.nav

object GithuberDestinations {
    const val USER_ID_ARGS = "uid"
    const val USER_FOLLOWING_STATE = "follow_status"
    const val HOME_PAGE = "home"
    const val USER_DETAILS_PAGE = "user_details"
    // home?uid=xxx&follow_status=true
    const val HOME_ROUTE = "$HOME_PAGE?$USER_ID_ARGS={$USER_ID_ARGS}&$USER_FOLLOWING_STATE={$USER_FOLLOWING_STATE}"
    // user_details?uid=xx
    const val USER_DETAILS_ROUTE = "$USER_DETAILS_PAGE?$USER_ID_ARGS={$USER_ID_ARGS}"
}

