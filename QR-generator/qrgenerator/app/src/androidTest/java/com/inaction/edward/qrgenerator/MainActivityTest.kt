package com.inaction.edward.qrgenerator

import android.support.test.rule.ActivityTestRule
import android.support.test.runner.AndroidJUnit4
import org.junit.Test

import android.support.test.espresso.Espresso.onView
import android.support.test.espresso.action.ViewActions.click
import android.support.test.espresso.assertion.ViewAssertions.matches
import android.support.test.espresso.matcher.ViewMatchers.*
import org.junit.Rule

import org.junit.runner.RunWith

/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
@RunWith(AndroidJUnit4::class)
class MainActivityTest {

    @Rule
    @JvmField
    val mActivityRule = ActivityTestRule(MainActivity::class.java)


    /**
     * Turn animation off on Developer Options before running this test
     */
    @Test
    fun testFabMenu() {

        onView(withId(R.id.scanFab))
                .check(matches(withAlpha(0f)))
        onView(withId(R.id.generateFab))
                .check(matches(withAlpha(0f)))

        onView(withId(R.id.fab_expand_menu_button))
                .perform(click())

        onView(withId(R.id.scanFab))
                .check(matches(withAlpha(1f)))
        onView(withId(R.id.generateFab))
                .check(matches(withAlpha(1f)))
    }


}
