package cn.hakim.animationapplication

import android.content.Context
import android.media.audiofx.LoudnessEnhancer
import android.util.Log

import cn.hakim.animationapplication.common.WeatherType
import cn.hakim.animationapplication.db.AppDataBase
import cn.hakim.animationapplication.db.LocalWeatherDataSource
import cn.hakim.animationapplication.db.entity.WeatherEntity
import cn.hakim.animationapplication.model.Weather
import cn.hakim.animationapplication.server.WeatherServerSource
import io.reactivex.Completable
import io.reactivex.Flowable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.annotations.NonNull
import io.reactivex.functions.Action
import io.reactivex.functions.Consumer
import io.reactivex.functions.Function
import io.reactivex.internal.operators.completable.CompletableFromAction
import io.reactivex.schedulers.Schedulers

/**
 * Created by Administrator on 2017/6/28.
 */

class WeatherRepository(context: Context) {
    private val mDataSource: WeatherDataSource
    private val mServerSource: WeatherDataSource

    init {
        val database = AppDataBase.getInstance(context)
        mDataSource = LocalWeatherDataSource(database.weatherDao())
        mServerSource = WeatherServerSource()
    }

    fun getWeatherById(id: Int): Flowable<WeatherEntity> {
        /*
        * NOTICE :RxRoom创建Flowable的时候把sql执行结果为null的值过滤掉了，导致查询为空无法收到结果反馈
        * https://github.com/googlesamples/android-architecture-components/issues/84
        */
        return mDataSource.getWeatherById(id)!!

    }

    private fun getWeatherFromNet(id: Int): WeatherEntity {
        val thread = Thread.currentThread()
        Log.e("=====", "thread.id:" + thread.id)
        val weather = WeatherEntity()
        weather.id = id
        weather.description = "天气晴朗，可以随意玩耍"
        weather.level = 100
        weather.name = "晴"
        weather.type = WeatherType.SUNSHINE.type
        return weather
    }

    fun refreshWeather(id: Int) {
        ////////////////////网络接口伪代码获取WeatherEntity省略/////////////////////
        //        Flowable<WeatherEntity> weather = mServerSource.getWeatherById(id);
        mDataSource.insertOrUpdateWeather(getWeatherFromNet(id))
    }
}
