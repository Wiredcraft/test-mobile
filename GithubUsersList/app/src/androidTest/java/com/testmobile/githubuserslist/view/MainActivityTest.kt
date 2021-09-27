package com.testmobile.githubuserslist.view

import androidx.recyclerview.widget.RecyclerView
import androidx.test.core.app.ActivityScenario
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.testmobile.githubuserslist.R
import com.testmobile.githubuserslist.adapter.UsersAdapter
import com.testmobile.githubuserslist.api.FakeUsersTestApi
import com.testmobile.githubuserslist.api.UserResponse
import com.testmobile.githubuserslist.model.User
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.runBlockingTest
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import javax.inject.Inject

/**
 * Sanity class to test the [MainActivity] views
 * */
@ExperimentalCoroutinesApi
@RunWith(AndroidJUnit4::class)
class MainActivityTest {

    @Inject
    lateinit var userResponse: UserResponse

    @Inject
    lateinit var usersAdapter: UsersAdapter

    @Inject
    lateinit var fakeUsersApi: FakeUsersTestApi

    @Before
    fun init(){
        ActivityScenario.launch(MainActivity::class.java)
        fakeUsersApi = FakeUsersTestApi()
        fakeUsersApi.addUser(User("4", "User4", "4", "https://uradfadfadl", "http://afatata.com"))
        fakeUsersApi.addUser(User("6", "User5", "9", "https://urladadfa", "http://afatata.com"))
        fakeUsersApi.addUser(User("8", "User6", "11", "https://uradafl", "http://afatata.com"))
        fakeUsersApi.addUser(User("9", "User7", "1", "https://uradfadfal", "http://afatata.com"))
        fakeUsersApi.addUser(User("10", "User8", "2", "https://uradfdadfl", "http://afatata.com"))
    }

    /**/
    @Test
    fun testRecyclerViewAdapterItemCount() = runBlockingTest{
        val appContext = InstrumentationRegistry.getInstrumentation().targetContext
        usersAdapter = UsersAdapter(appContext)
        onView(withId(R.id.recycler_view)).check { view, noViewFoundException ->
            if (noViewFoundException != null) {
                throw noViewFoundException
            }


            val recyclerView = view as RecyclerView
            recyclerView.adapter = usersAdapter
            Assert.assertEquals(0, recyclerView.adapter?.itemCount)

        }
    }

    // test visibility of the swipe refresh layout
    @Test
    fun swipeRefreshLayoutVisibility(){
        onView(withId(R.id.swipe_refresh_layout)).check(matches(isDisplayed()))
    }

    // check if the recyclerview is displaed
    @Test
    fun recyclerViewVisibility(){
        onView(withId(R.id.recycler_view)).check(matches(isDisplayed()))
    }

    @Test
    fun userResponseTest() = runBlockingTest{
        userResponse = fakeUsersApi.searchUsers("android", 1, 6);

        //expects 6
        Assert.assertEquals(6, userResponse.totalCount)
    }

    // test visibility of the swip refresh layout
    @Test
    fun retryButtonVisibility(){
        onView(withId(R.id.activity_main_button_retry)).check(matches(isDisplayed()))
    }

}