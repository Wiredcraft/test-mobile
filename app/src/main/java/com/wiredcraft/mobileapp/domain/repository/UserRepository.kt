package com.wiredcraft.mobileapp.domain.repository

import com.wiredcraft.mobileapp.bean.RepositoryBean
import com.wiredcraft.mobileapp.bean.UserBean
import com.wiredcraft.mobileapp.domain.NetService
import com.wiredcraft.mobileapp.domain.UIState
import com.wiredcraft.mobileapp.domain.toUIState
import com.wiredcraft.mobileapp.domain.toUIStateOrThrows
import com.wiredcraft.mobileapp.net.bean.DataResult
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import kotlinx.coroutines.flow.onStart

/**
 * createTime：2023/5/30
 * author：lhq
 * desc: nitiate a network request at the repository layer,
 * and then convert the request result. Here you can save the data to a database or file
 *
 */
class UserRepository {

    /**
     * query users
     * @param queryWords the words for query
     * @param page pageNum
     */
    suspend fun queryUsers(queryWords: String, page: Int) = flow {
        val userList = NetService.SERVICE.queryUsers(queryWords, page)
        //map data to our datasource
        val mapData = userList.items?.map { UserBean(it.id, it.avatarURL, it.login, it.htmlURL, it.score, false) }
        emit(DataResult(true, mapData).toUIStateOrThrows())
    }.onStart {
        emit(UIState.onLoading())
    }.flowOn(Dispatchers.IO).catch {
        emit(it.toUIState())
    }

    /**
     * query user repositories
     * @param userName query words
     */
    suspend fun queryUserRepositories(userName: String) = flow {
        val info = NetService.SERVICE.queryUserRepositories(userName)
        //map data to our repository datasource
        val mapData = info?.map { RepositoryBean(it.id, it.name, it.owner?.avatarURL, it.stargazersCount, it.htmlURL) }
        emit(DataResult(true, mapData).toUIStateOrThrows())
    }.onStart {
        emit(UIState.onLoading())
    }.flowOn(Dispatchers.IO).catch {
        it.printStackTrace()
        emit(it.toUIState())
    }

}
