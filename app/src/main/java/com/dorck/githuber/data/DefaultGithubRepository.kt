package com.dorck.githuber.data

import com.dorck.githuber.data.entities.GithubRepo
import com.dorck.githuber.data.entities.UsersSearchResult
import com.dorck.githuber.data.source.common.Result
import com.dorck.githuber.data.source.local.LocalDataSource
import com.dorck.githuber.data.source.remote.NetworkDataSource
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import javax.inject.Inject
import javax.inject.Singleton
import kotlin.coroutines.CoroutineContext

@Singleton
class DefaultGithubRepository @Inject constructor(
    private val localDataSource: LocalDataSource,
    private val remoteDataSource: NetworkDataSource,
    private val ioDispatcher: CoroutineContext
) : GithubDataRepository {
    override suspend fun searchUsers(
        keyword: String,
        page: Int,
        perPage: Int
    ): Flow<Result<UsersSearchResult>> {
        return flow {
            emit(Result.Loading())
            remoteDataSource.searchUsers(keyword, page, perPage).run {
                emit(this)
            }
        }.flowOn(ioDispatcher)
    }

    override suspend fun requestRepos(
        username: String,
        page: Int,
        perPage: Int
    ): Flow<Result<List<GithubRepo>>> {
        return flow {
            emit(Result.Loading())
            remoteDataSource.fetchRepos(username, page, perPage).run {
                emit(this)
            }
        }.flowOn(ioDispatcher)
    }

    override suspend fun follow(uid: String): Flow<Result<Boolean>> {
        return flow {
            emit(Result.Loading())
            // Simulate the data request process.
            kotlinx.coroutines.delay(500)
            localDataSource.followUser(uid).run {
                emit(Result.Success(this))
            }
        }.flowOn(ioDispatcher)
    }

}