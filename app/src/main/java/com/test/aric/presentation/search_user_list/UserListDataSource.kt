package com.test.aric.presentation.search_user_list

import androidx.paging.PagingSource
import androidx.paging.PagingState
import com.test.aric.data.remote.dto.UserInfo
import com.test.aric.domain.repository.GithubRepository


class UserListDataSource(private val userName: String, private val searchUsersUseCase: GithubRepository) :
    PagingSource<Int, UserInfo>() {

    override fun getRefreshKey(state: PagingState<Int, UserInfo>): Int? {
        return state.anchorPosition?.let {
            val anchorPage = state.closestPageToPosition(it)
            anchorPage?.prevKey?.plus(1) ?: anchorPage?.nextKey?.minus(1)
        }
    }

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, UserInfo> {
        return try {
            val currentPage: Int = params.key ?: 1
            val userListResponse = searchUsersUseCase.searchUserByName(userName, currentPage.toString())
            LoadResult.Page(
                data = userListResponse.items,
                prevKey = if (currentPage == 1) null else currentPage - 1,
                nextKey = if (userListResponse.total_count< currentPage *params.loadSize) null else currentPage + 1
            )
        } catch (e: Exception) {
            e.printStackTrace()
            LoadResult.Error(e)
        }
    }
}
