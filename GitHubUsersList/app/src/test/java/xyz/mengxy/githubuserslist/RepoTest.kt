package xyz.mengxy.githubuserslist

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Before
import org.junit.Test
import xyz.mengxy.githubuserslist.model.Repo
import xyz.mengxy.githubuserslist.model.User

/**
 * Created by Mengxy on 3/29/22.
 */
class RepoTest {

    private lateinit var repo: Repo

    @Before
    fun setUp() {
        repo = Repo("1", "TestRepo", "1.0", "", User(
            "1", "jaymengxy", "https://avatars.githubusercontent.com/u/4037833?v=4",
            "https://github.com/jaymengxy", null
        ))
    }

    @Test
    fun test_repoAvatarUrl() {
        assertEquals("https://avatars.githubusercontent.com/u/4037833?v=4", repo.getAvatarUrl())
    }

    @Test
    fun test_isUserInfo() {
        assertFalse(repo.isUserInfo())
    }
}
