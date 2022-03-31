package xyz.mengxy.githubuserslist.model

import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import kotlinx.coroutines.flow.Flow
import xyz.mengxy.githubuserslist.api.NetworkService
import javax.inject.Inject

/**
 * Created by Mengxy on 3/29/22.
 * return repo result flow by [UserPagingSource] to [UserViewModel]
 */
class UserRepository @Inject constructor(private val service: NetworkService) {

    companion object {
        private const val PAGE_SIZE = 25
    }

    fun getSearchResultStream(query: String): Flow<PagingData<User>> {
        return Pager(
            config = PagingConfig(enablePlaceholders = false, pageSize = PAGE_SIZE),
            pagingSourceFactory = { UserPagingSource(service, query) }
        ).flow
    }
}