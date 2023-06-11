package com.dorck.githuber.data.source.local

import javax.inject.Inject
import javax.inject.Singleton

/**
 * Simple implementation of [LocalDataSource].
 * @author Dorck
 */
@Singleton
class GithubLocalDataSource @Inject constructor() : LocalDataSource {
    private var followersMap = hashMapOf<String, Boolean>()

    override suspend fun followUser(uid: String, isToFollow: Boolean): Boolean {
        followersMap[uid] = isToFollow
        // Mock data, always returns true.
        return true
    }
}