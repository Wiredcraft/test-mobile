package com.testmobile.githubuserslist.api

import android.webkit.URLUtil
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.testmobile.githubuserslist.model.User
import io.reactivex.Scheduler
import io.reactivex.android.plugins.RxAndroidPlugins
import io.reactivex.disposables.Disposable
import io.reactivex.internal.schedulers.ExecutorScheduler
import io.reactivex.plugins.RxJavaPlugins
import org.junit.Assert
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.mockito.MockitoAnnotations
import java.util.concurrent.Executor
import java.util.concurrent.TimeUnit

/**
 * sanity to class to test the api using RxJava
 * */
class UsersApiTest {

    @get:Rule
    val instantTaskExecutorRule = InstantTaskExecutorRule()

    /**
     * @Before runs before any function
     **/
    @Before
    fun setUp() {
        MockitoAnnotations.initMocks(this)
    }

    /**
     * @Before runs before any function
     **/
    @Before
    fun setUpRxSchedulers(){
        val immediate = object : Scheduler() {
            override fun scheduleDirect(run: Runnable?, delay: Long, unit: TimeUnit?): Disposable {
                /* delay = 0: Don't delay when scheduler is called*/
                return super.scheduleDirect(run, 0, unit)
            }
            override fun createWorker(): Worker {
                return ExecutorScheduler.ExecutorWorker(Executor { it.run() })
            }
        }
        /*
        * Use the immediate value return for all scheduling done
        * by RxJava && RxAndroid
        * */
        RxJavaPlugins.setInitIoSchedulerHandler { immediate }
        RxJavaPlugins.setInitComputationSchedulerHandler { immediate }
        RxJavaPlugins.setInitNewThreadSchedulerHandler { immediate }
        RxJavaPlugins.setInitSingleSchedulerHandler { immediate }
        RxAndroidPlugins.setInitMainThreadSchedulerHandler { immediate }
    }

    @Test
    fun `should match size given a list of users`(){
        // Given a  new instance of user
        val user =  User("1", "user1", "1", "http://github.com/user/img.png", "http://github.com/user/1")

        // when
        val usersList = arrayListOf(user)

        // Then
        Assert.assertEquals(1, usersList.size)
    }

    @Test
    fun `should match a avatar url given a user`(){
        // Given a  new instance of user
        val user =  User("1", "user1", "1", "http://github.com/user/img.png", "http://github.com/user/1")
        // when
        val avatarUrl = user.avatarUrl
        //then
        Assert.assertEquals(false, URLUtil.isValidUrl(avatarUrl))
    }

    @Test
    fun `should match a url given a user`(){
        // Given a  new instance of user
        val user =  User("1", "user1", "1", "http://github.com/user/img.png", "http://github.com/user/1")
        // when
        val url = user.url
        //then
        Assert.assertEquals(false, URLUtil.isValidUrl(url))

    }
}