package xyz.mengxy.githubuserslist

import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import xyz.mengxy.githubuserslist.model.User

/**
 * Created by Mengxy on 3/29/22.
 */
class UserTest {

    private lateinit var user: User

    @Before
    fun setUp() {
        user = User(
            "1", "jaymengxy", "https://avatars.githubusercontent.com/u/4037833?v=4",
            "https://github.com/jaymengxy", null
        )
    }

    @Test
    fun test_defaultScore() {
        assertEquals("0", user.getScore())
    }

    @Test
    fun test_isUserInfo() {
        assertTrue(user.isUserInfo())
    }
}