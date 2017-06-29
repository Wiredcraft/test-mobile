package cn.hakim.animationapplication

import cn.hakim.animationapplication.db.entity.WeatherEntity
import cn.hakim.animationapplication.model.Weather
import io.reactivex.Flowable

/**
 * Created by Administrator on 2017/6/26.
 * 获取weather数据。使用接口可扩展从数据库获取，从网络获取等多种方式
 */

interface WeatherDataSource {
    val weathers: Flowable<List<WeatherEntity>>?

    fun getWeatherById(id: Int): Flowable<WeatherEntity>?

    fun insertOrUpdateWeather(weather: WeatherEntity)

}
