package xyz.mengxy.githubuserslist

import androidx.navigation.findNavController
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.closeSoftKeyboard
import androidx.test.espresso.action.ViewActions.typeText
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.rule.ActivityTestRule
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Created by Mengxy on 3/30/22.
 * learning espresso
 */
@RunWith(AndroidJUnit4::class)
class UserListFragmentTest {

    @Rule
    @JvmField
    val activityTestRule = ActivityTestRule(MainActivity::class.java)

    @Before
    fun jumpToUserListFragment() {
        activityTestRule.activity.apply {
            runOnUiThread {
                findNavController(R.id.nav_host).navigate(R.id.user_list_fragment)
            }
        }
    }

    @Test
    fun testSearchEdit() {
        onView(withId(R.id.et_search)).perform(typeText("Espresso"), closeSoftKeyboard())
    }

    @Test
    fun testRecyclerView() {
        onView(withId(R.id.rv_user_list)).check(matches(isDisplayed()))
    }
}