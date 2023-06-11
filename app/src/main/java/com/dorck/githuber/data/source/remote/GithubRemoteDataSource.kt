package com.dorck.githuber.data.source.remote

import com.dorck.githuber.data.entities.GithubRepo
import com.dorck.githuber.data.entities.UsersSearchResult
import com.dorck.githuber.data.source.common.Result
import com.dorck.githuber.data.source.remote.service.GithubService
import com.dorck.githuber.utils.NETWORK_ERROR
import retrofit2.Response
import java.io.IOException
import javax.inject.Inject

/**
 * Fetch github data by network request.
 * @author Dorck
 */
class GithubRemoteDataSource @Inject constructor(
    private val serviceProvider: RetrofitServiceProvider
) : NetworkDataSource {
    private val githubService: GithubService by lazy {
        serviceProvider.getService(GithubService::class.java)
    }

    override suspend fun searchUsers(
        keyword: String,
        page: Int,
        perPage: Int
    ): Result<UsersSearchResult> {
        return when(val data = processResponse { githubService.searchUsers(keyword, page, perPage) }) {
            is UsersSearchResult -> Result.Success(data)
            else -> data as Result.Error<UsersSearchResult>
        }

    }

    override suspend fun fetchRepos(
        username: String,
        page: Int,
        perPage: Int
    ): Result<List<GithubRepo>> {
        return when(val data = processResponse { githubService.getUserRepoList(username, page, perPage) }) {
            is List<*> -> Result.Success(data as List<GithubRepo>)
            else -> data as Result.Error<List<GithubRepo>>
        }
    }


    private suspend fun processResponse(response: suspend () -> Response<*>): Any? =
        try {
            val responseData = response.invoke()
            if (responseData.isSuccessful) {
                responseData.body()
            } else {
                Result.Error<Any>(responseData.code(), responseData.message() ?: "")
            }
        } catch (e: IOException) {
            Result.Error<Any>(NETWORK_ERROR, "There may be a problem with the network.")
        }
}