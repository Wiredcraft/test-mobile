package com.inaction.edward.qrgenerator.database

import android.arch.persistence.room.Database
import android.arch.persistence.room.Room
import android.arch.persistence.room.RoomDatabase
import android.content.Context
import com.inaction.edward.qrgenerator.entities.Seed

@Database(entities = arrayOf(Seed::class), version = 1, exportSchema = false)
abstract class AppDatabase: RoomDatabase() {

    companion object {
        lateinit var appDataBase: AppDatabase

        fun init(context: Context) {
            appDataBase =
                    Room.databaseBuilder(context, AppDatabase::class.java, "app-db").build()
        }
    }

    abstract fun seedDao(): SeedDao

}
