package xyz.mengxy.githubuserslist.model

import androidx.paging.PagingSource
import androidx.paging.PagingState
import xyz.mengxy.githubuserslist.api.NetworkService
import xyz.mengxy.githubuserslist.util.STARTING_PAGE_INDEX

/**
 * Created by Mengxy on 3/29/22.
 * load data from api service and set to paging load result
 */
class RepoPagingSource(
    private val service: NetworkService,
    private val userName: String
) : PagingSource<Int, Repo>() {
    override fun getRefreshKey(state: PagingState<Int, Repo>): Int? {
        return state.anchorPosition?.let { position -> state.closestPageToPosition(position)?.prevKey }
    }

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, Repo> {
        val page = params.key ?: STARTING_PAGE_INDEX
        return try {
            val repoList = service.getUserRepos(userName, page, params.loadSize)
            LoadResult.Page(
                data = repoList,
                prevKey = if (page == STARTING_PAGE_INDEX) null else page - 1,
                nextKey = if (repoList.isEmpty()) null else page + 1
            )
        } catch (e: Exception) {
            LoadResult.Error(e)
        }
    }
}
