package cn.hakim.animationapplication.server

import cn.hakim.animationapplication.WeatherDataSource
import cn.hakim.animationapplication.db.entity.WeatherEntity
import io.reactivex.Flowable

/**
 * Created by Administrator on 2017/6/28.
 * 使用retrofit请求网络，忽略
 */

class WeatherServerSource : WeatherDataSource {
    override val weathers: Flowable<List<WeatherEntity>>?
        get() = null

    override fun getWeatherById(id: Int): Flowable<WeatherEntity>? {
        return null
    }

    override fun insertOrUpdateWeather(weather: WeatherEntity) {

    }
}
