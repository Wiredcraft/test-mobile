package com.wiredcraft.githubuser.network

import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

object GitHubNetwork {
    private val gitHubService = ServiceCreator.create(GitHubService::class.java)

    suspend fun getGithubUsers(q: String, page: Int) = gitHubService.getGitHubUsers(q, page).await()

    suspend fun getUserRepos() = gitHubService.getUserRepos().await()

    private suspend fun <T> Call<T>.await(): T {
        return suspendCoroutine { continuation ->
            enqueue(object : Callback<T> {
                override fun onResponse(call: Call<T>, response: Response<T>) {
                    val body = response.body()
                    if (body != null) continuation.resume(body)
                    else continuation.resumeWithException(RuntimeException("response body is null"))
                }

                override fun onFailure(call: Call<T>, t: Throwable) {
                    continuation.resumeWithException(t)
                }
            })
        }
    }
}