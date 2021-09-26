package com.testmobile.githubuserslist.api

import android.util.Log
import androidx.paging.PagingSource
import com.testmobile.githubuserslist.model.User
import retrofit2.HttpException
import java.io.IOException

private const val USERS_PAGE_STARTING_INDEX = 1

/**
 * [UserPagingSource] loads data from the [Retrofit] api and
 * pages/feeds the data to the paging data class
 * */
class UserPagingSource(
    private val userApi: UsersApi,
    private val query: String
) : PagingSource<Int, User>() {

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, User> {
        val position = params.key ?: USERS_PAGE_STARTING_INDEX

        return try {
            // params.loadsize is the number of items to be loaded
            val response = userApi.searchUsers(query, position, params.loadSize)
            Log.d(UserPagingSource::class.simpleName.toString(), params.loadSize.toString())
            val users = response.results

            // load the paged results from the paging source
            LoadResult.Page(
                data = users,
                prevKey = if (position == USERS_PAGE_STARTING_INDEX) null else position - 1,
                // always increase the next key by 1 using the current position
                nextKey = if (users.isEmpty()) null else position + 1
            )
        } catch (exception: IOException) {
            Log.d(UserPagingSource::class.simpleName.toString(), exception.toString())
            LoadResult.Error(exception)
        } catch (exception: HttpException) {
            LoadResult.Error(exception)
        }
    }

}