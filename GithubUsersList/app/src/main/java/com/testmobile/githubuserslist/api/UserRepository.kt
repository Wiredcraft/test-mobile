package com.testmobile.githubuserslist.api

import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.liveData
import javax.inject.Inject
import javax.inject.Singleton

/**
 * This class returns the paged data consumed by the [UserPagingSource]
 * @Singleton annotation makes the class a single instance in the dependencies graph
 * during the entire applications life time
 * @Inject annotation provides the same instance of this class
 * */
@Singleton
class UserRepository @Inject constructor(private val usersApi: UsersApi) {

    /**
     * Returns a [liveData] paged results
     * params -> query: required to enable quering by the keyword provided
     * */
    fun getSearchResults(query: String) =
        Pager(
            config = PagingConfig(
                pageSize = PAGE_SIZE,
                maxSize = MAX_SIZE,
                enablePlaceholders = false
            ),
            pagingSourceFactory = { UserPagingSource(usersApi, query) }
        ).liveData

    companion object {
        const val PAGE_SIZE = 30
        const val MAX_SIZE = 100
    }

}