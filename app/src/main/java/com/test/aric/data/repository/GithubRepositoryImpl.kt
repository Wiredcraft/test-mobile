package com.test.aric.data.repository

import com.test.aric.data.remote.GithubApi
import com.test.aric.domain.repository.GithubRepository
import javax.inject.Inject

class GithubRepositoryImpl @Inject constructor(
    private val api: GithubApi
) : GithubRepository {
    override suspend fun searchUserByName(q: String, page: String) = api.searchUserByName(q, page)

    override suspend fun getAllFollowers(user: String) = api.getAllFollowers(user)

    override suspend fun getAllRepos(user: String) = api.getAllRepos(user)

}