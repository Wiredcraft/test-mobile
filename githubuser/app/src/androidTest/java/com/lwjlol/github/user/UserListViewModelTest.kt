package com.lwjlol.github.user

import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.lwjlol.github.user.ui.UserListViewModel
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.map
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
@RunWith(AndroidJUnit4::class)
class UserListViewModelTest {
    val viewModel = UserListViewModel(UserListViewModel.State())
    val scope = MainScope()

    @Before
    fun init() {
        viewModel.state.map {
            println(it)
        }.launchIn(scope)
    }

    @Test
    fun refreshUsers() {
        viewModel.getUsers(true)
    }

    @Test
    fun loadMoreUsers() {
        viewModel.getUsers(false)
    }
}