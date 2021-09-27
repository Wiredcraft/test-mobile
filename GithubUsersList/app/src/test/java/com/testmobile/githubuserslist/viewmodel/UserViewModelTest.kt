package com.testmobile.githubuserslist.viewmodel

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.SavedStateHandle
import com.testmobile.githubuserslist.adapter.UsersAdapter
import com.testmobile.githubuserslist.api.FakeUsersApi
import com.testmobile.githubuserslist.api.UserRepository
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Assert
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.mockito.MockitoAnnotations
import javax.inject.Inject

/**
 * Sanity class to the test [UserViewModel] class
 * */
@OptIn(ExperimentalCoroutinesApi::class)
class UserViewModelTest {

    // swaps the background executor using a different one to execute task synchronously
    @get:Rule
    var rule = InstantTaskExecutorRule()

    //late init variables
    private lateinit var userRepository: UserRepository
    private lateinit var savedStateHandle: SavedStateHandle
    private lateinit var userViewModel: UserViewModel

    @Inject
    lateinit var usersAdapter: UsersAdapter

    @Inject
    lateinit var fakeUsersApiUnitTest: FakeUsersApi


    @ExperimentalCoroutinesApi
    @Before
    fun init() = runBlockingTest {
        //initiliase mockito
        MockitoAnnotations.initMocks(this)
        savedStateHandle = SavedStateHandle()
        fakeUsersApiUnitTest = FakeUsersApi()
        userRepository = UserRepository(fakeUsersApiUnitTest)
        userViewModel = UserViewModel(repository = userRepository, state = savedStateHandle)
        usersAdapter = UsersAdapter(null)
        userViewModel.searchUsers("react")
    }

    @ExperimentalCoroutinesApi
    @Test
    fun testViewModel() = runBlockingTest {
        Assert.assertEquals(null, userViewModel.users.value)
    }

}