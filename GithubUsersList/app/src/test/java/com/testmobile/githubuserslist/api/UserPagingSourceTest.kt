package com.testmobile.githubuserslist.api

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.paging.PagingSource
import com.testmobile.githubuserslist.model.User
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.mockito.MockitoAnnotations
import kotlin.test.assertEquals

/**
 * [UserPagingSourceTest]  sanity class to the test the [UserPagingSource]
 * paged results by a using an instance of the [FakeUsersApi] class
 * */
@OptIn(ExperimentalCoroutinesApi::class)
class UserPagingSourceTest{

    // swaps the background executor using a different one to execute task synchronously
    @get:Rule
    val instantTaskExecutorRule = InstantTaskExecutorRule()

 // initialise mockito
    @Before
    fun setUp() {
        MockitoAnnotations.initMocks(this)
    }

    // default query for testing
    companion object{
        const val QUERY = "android"
    }

    // create a list of fake users
    private val fakeUsers = listOf(
        User("1", "name1", "1", "http://www.com", "http://yrl.com"),
        User("2", "name2", "2", "http://www.com", "http://yrl.com"),
        User("3", "name3", "3", "http://www.com", "http://yrl.com"),
        User("4", "name4", "4", "http://www.com", "http://yrl.com"),
        User("5", "name5", "5", "http://www.com", "http://yrl.com"),
    )

    /**
     * instance of [FakeUsersApi] class
     * **/
    private val fakeApi = FakeUsersApi().apply {
        fakeUsers.forEach {
            // add fake users to the list of user in the base class
                user -> addUser(user)
        }
    }


    @Test
    fun userPagingSource() = runBlockingTest{
        // given an instance of user paging source
        val pagingSource = UserPagingSource(fakeApi, QUERY)

        // when
       val expected = PagingSource.LoadResult.Page(
            data = listOf(fakeUsers),
            prevKey = 1,
            nextKey = 2
        )
        val actual = pagingSource.load(
            PagingSource.LoadParams.Refresh(
                key = null,
                loadSize = 2,
                placeholdersEnabled = false
            )
        )

        // then
        assertEquals( expected, actual)
    }

}