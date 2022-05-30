package com.wiredcraft

import com.wiredcraft.network.RetrofitUtil
import com.wiredcraft.service.GithubApi
import kotlinx.coroutines.runBlocking
import org.junit.Test

class GithubApiTest {
    private val githubAPI = RetrofitUtil.create(GithubApi::class.java)

    @Test
    fun searchUsers() {
        runBlocking {
            val result = githubAPI.searchUser()
            println(result)
        }
    }

    @Test
    fun userFollowers() {
        runBlocking {
            println("userFollowers")
        }
    }

    @Test
    fun userRepos() {
        runBlocking {
            val result = githubAPI.userRepos("wangxiang91")
            println(result)
        }
    }
}