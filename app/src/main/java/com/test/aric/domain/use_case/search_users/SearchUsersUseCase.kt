package com.test.aric.domain.use_case.search_users

import com.test.aric.common.Resource
import com.test.aric.data.remote.dto.UserSearchResult
import com.test.aric.domain.repository.GithubRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import retrofit2.HttpException
import java.io.IOException
import javax.inject.Inject

class SearchUsersUseCase @Inject constructor(
    private val repository: GithubRepository
) {
    operator fun invoke(q: String,page:String): Flow<Resource<UserSearchResult>> = flow {
        try {
            emit(Resource.Loading())
            val coin = repository.searchUserByName(q, page)
            emit(Resource.Success(coin))
        } catch(e: HttpException) {
            emit(Resource.Error(e.localizedMessage ?: "An unexpected error occured"))
        } catch(e: IOException) {
            emit(Resource.Error("Couldn't reach server. Check your internet connection."))
        }
    }
}