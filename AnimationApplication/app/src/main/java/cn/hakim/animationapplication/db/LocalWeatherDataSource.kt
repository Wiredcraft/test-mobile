package cn.hakim.animationapplication.db

import android.util.Log

import java.util.ArrayList

import cn.hakim.animationapplication.WeatherDataSource
import cn.hakim.animationapplication.db.dao.WeatherDao
import cn.hakim.animationapplication.db.entity.WeatherEntity
import cn.hakim.animationapplication.model.Weather
import io.reactivex.Flowable

/**
 * Created by Administrator on 2017/6/26.
 */

class LocalWeatherDataSource(private val mDao: WeatherDao) : WeatherDataSource {
    override val weathers: Flowable<List<WeatherEntity>>
        get() = mDao.all

    override fun getWeatherById(id: Int): Flowable<WeatherEntity> {
        return mDao.loadWeatherSync(id)
    }

    override fun insertOrUpdateWeather(weather: WeatherEntity) {
        mDao.insert(weather)
    }
}
