package com.test.aric.domain.use_case.get_repos

import com.test.aric.common.Resource
import com.test.aric.data.remote.dto.RepoInfo
import com.test.aric.domain.repository.GithubRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import retrofit2.HttpException
import java.io.IOException
import javax.inject.Inject

class GetReposUseCase @Inject constructor(
    private val repository: GithubRepository
) {
    operator fun invoke(user: String): Flow<Resource<List<RepoInfo>>> = flow {
        try {
            emit(Resource.Loading<List<RepoInfo>>())
            val repos = repository.getAllRepos(user)
            emit(Resource.Success<List<RepoInfo>>(repos))
        } catch(e: HttpException) {
            emit(Resource.Error<List<RepoInfo>>(e.localizedMessage ?: "An unexpected error occured"))
        } catch(e: IOException) {
            emit(Resource.Error<List<RepoInfo>>("Couldn't reach server. Check your internet connection."))
        }
    }
}