package com.dorck.githuber.data.source.remote

import com.dorck.githuber.data.entities.GithubRepo
import com.dorck.githuber.data.entities.UsersSearchResult
import com.dorck.githuber.data.source.common.Result

interface NetworkDataSource {

    suspend fun searchUsers(keyword: String, page: Int, perPage: Int): Result<UsersSearchResult>

    suspend fun fetchRepos(username: String, page: Int, perPage: Int): Result<List<GithubRepo>>
}