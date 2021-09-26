package com.testmobile.githubuserslist.util

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

/**
* Hilt depedency injection requires the application class to be annotated with @HiltAndroidApp
* [GithubUsersListApplication] provides dependencies for other components to access
*/
@HiltAndroidApp
class GithubUsersListApplication: Application()