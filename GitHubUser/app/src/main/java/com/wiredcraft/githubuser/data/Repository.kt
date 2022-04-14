package com.wiredcraft.githubuser.data

import kotlin.coroutines.CoroutineContext
import androidx.lifecycle.liveData
import com.wiredcraft.githubuser.network.GitHubNetwork
import kotlinx.coroutines.Dispatchers

object Repository {
    fun searchUsers(q: String, page: Int) = fire(Dispatchers.IO) {
        val userResponse = GitHubNetwork.getGithubUsers(q, page)
        if (!userResponse.items.isNullOrEmpty()){
            val users = userResponse.items
            Result.success(users)
        } else {
            Result.failure<RuntimeException>(RuntimeException("response is error"))
        }
    }

    fun getReposList() = fire(Dispatchers.IO) {
        val repoResponse = GitHubNetwork.getUserRepos()
        Result.success(repoResponse)
    }

    private fun <T> fire(context: CoroutineContext, block: suspend () -> Result<T>) =
        liveData<Result<T>>(context) {
            val result = try {
                block()
            } catch (e: Exception) {
                Result.failure<T>(e)
            }
            emit(result)
        }
}