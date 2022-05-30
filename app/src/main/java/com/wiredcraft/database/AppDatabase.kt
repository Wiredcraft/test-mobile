package com.wiredcraft.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.wiredcraft.bean.FollowState
import com.wiredcraft.dao.FollowDao

@Database(entities = [FollowState::class], version = 1)
abstract class AppDatabase : RoomDatabase() {

    companion object {
        private lateinit var db: AppDatabase
        fun initialize(context: Context) {
            db = Room.databaseBuilder(context, AppDatabase::class.java, "com.wiredcraft").build()
        }

        fun getInstance() = db
    }

    abstract fun userDao(): FollowDao
}
