package com.wiredcraft

import android.content.Context
import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.wiredcraft.bean.FollowState
import com.wiredcraft.dao.FollowDao
import com.wiredcraft.database.AppDatabase
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import java.io.IOException


@RunWith(AndroidJUnit4::class)
class FollowDaoTest {
    private lateinit var followDao: FollowDao
    private lateinit var db: AppDatabase

    @Before
    fun createDb() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        db = Room.inMemoryDatabaseBuilder(
            context, AppDatabase::class.java
        ).build()
        followDao = db.userDao()
    }

    @Test
    fun insert() {
        runBlocking {
            followDao.insertAll(
                FollowState(111, false),
                FollowState(222, false),
                FollowState(333, false)
            )
            getAll()
        }
    }

    @Test
    fun update() {
        runBlocking {
            insert()
            followDao.insertOrUpdate(FollowState(222, true))
            followDao.insertOrUpdate(FollowState(444, true))
            getAll()
        }
    }

    @Test
    fun delete() {
        runBlocking {
            insert()
            followDao.deleteById(111)
            getAll()
        }
    }

    @Test
    fun getAll() {
        runBlocking {
            println(followDao.getAll())
        }
    }

    @After
    @Throws(IOException::class)
    fun closeDb() {
        db.close()
    }
}
