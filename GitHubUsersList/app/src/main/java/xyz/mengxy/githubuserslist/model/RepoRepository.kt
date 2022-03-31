package xyz.mengxy.githubuserslist.model

import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import kotlinx.coroutines.flow.Flow
import xyz.mengxy.githubuserslist.api.NetworkService
import javax.inject.Inject

/**
 * Created by Mengxy on 3/29/22.
 * return repo result flow by [RepoPagingSource] to [RepoViewModel]
 */
class RepoRepository @Inject constructor(private val service: NetworkService) {

    companion object {
        private const val PAGE_SIZE = 10
    }

    fun getReposResultStream(userName: String): Flow<PagingData<Repo>> {
        return Pager(
            config = PagingConfig(enablePlaceholders = false, pageSize = PAGE_SIZE),
            pagingSourceFactory = { RepoPagingSource(service, userName) }
        ).flow
    }
}
