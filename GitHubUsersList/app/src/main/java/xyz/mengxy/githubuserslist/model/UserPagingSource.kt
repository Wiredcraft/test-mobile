package xyz.mengxy.githubuserslist.model

import androidx.paging.PagingSource
import androidx.paging.PagingState
import xyz.mengxy.githubuserslist.api.NetworkService

/**
 * Created by Mengxy on 3/29/22.
 */
class UserPagingSource(
    private val service: NetworkService,
    private val query: String
) : PagingSource<Int, User>() {

    override fun getRefreshKey(state: PagingState<Int, User>): Int? {
        return state.anchorPosition?.let { position -> state.closestPageToPosition(position)?.prevKey }
    }

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, User> {
        val page = params.key ?: STARTING_PAGE_INDEX
        return try {
            val response = service.searchUsers(query, page, params.loadSize)
            val userList = response.userList
            // because there is no total_page param, so when the user list is empty it means is the last page
            LoadResult.Page(
                data = userList,
                prevKey = if (page == STARTING_PAGE_INDEX) null else page - 1,
                nextKey = if (userList.isEmpty()) null else page + 1
            )
        } catch (e: Exception) {
            LoadResult.Error(e)
        }
    }
}
