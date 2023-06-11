package com.dorck.githuber.data.source.local

/**
 * Provide local abilities of github api.
 * @author Dorck
 */
interface LocalDataSource {
    suspend fun followUser(uid: String): Boolean
}