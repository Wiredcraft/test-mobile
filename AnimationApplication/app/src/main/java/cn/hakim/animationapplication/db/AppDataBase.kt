package cn.hakim.animationapplication.db

import android.arch.persistence.room.Database
import android.arch.persistence.room.Room
import android.arch.persistence.room.RoomDatabase
import android.content.Context

import cn.hakim.animationapplication.db.dao.WeatherDao
import cn.hakim.animationapplication.db.entity.WeatherEntity

/**
 * Created by Administrator on 2017/6/23.
 */
@Database(entities = arrayOf(WeatherEntity::class), version = 1)
abstract class AppDataBase : RoomDatabase() {

    abstract fun weatherDao(): WeatherDao

    companion object {
        internal val DATABASE_NAME = "animator.db"
        private var mInstance: AppDataBase? = null
        fun getInstance(context: Context): AppDataBase {
            if (mInstance == null) {
                synchronized(AppDataBase::class.java) {
                    if (mInstance == null) {
                        mInstance = Room.databaseBuilder<AppDataBase>(context.applicationContext, AppDataBase::class.java!!, DATABASE_NAME)
                                .build()
                    }
                }
            }
            return mInstance!!
        }
    }
}
