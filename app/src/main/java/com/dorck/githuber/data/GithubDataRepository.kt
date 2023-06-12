package com.dorck.githuber.data

import com.dorck.githuber.data.entities.GithubRepo
import com.dorck.githuber.data.entities.UsersSearchResult
import kotlinx.coroutines.flow.Flow
import com.dorck.githuber.data.source.common.Result

interface GithubDataRepository {
    suspend fun searchUsers(
        keyword: String,
        page: Int,
        perPage: Int
    ): Flow<Result<UsersSearchResult>>

    suspend fun requestRepos(
        username: String,
        page: Int = 1,
        perPage: Int = 30
    ): Flow<Result<List<GithubRepo>>>

    suspend fun follow(uid: String): Flow<Result<Boolean>>
}