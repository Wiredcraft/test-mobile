package cn.hakim.animationapplication.viewmodel

import android.arch.lifecycle.ViewModel
import android.util.Log

import cn.hakim.animationapplication.WeatherRepository
import cn.hakim.animationapplication.db.entity.WeatherEntity
import cn.hakim.animationapplication.model.Weather
import io.reactivex.Completable
import io.reactivex.Flowable
import io.reactivex.functions.Action
import io.reactivex.functions.Function
import io.reactivex.internal.operators.completable.CompletableFromAction

/**
 * Created by Administrator on 2017/6/26.
 * 使用viewmodel管理observer生命周期，防止内存泄露
 * 也可以引用RxLifecycle来省略这一过程
 */

class WeatherViewModel(private val mRepository: WeatherRepository) : ViewModel() {
    private val mWeather: WeatherEntity? = null

    fun getWeatherLevel(id: Int): Flowable<Int> {
        return mRepository.getWeatherById(id)
                .map { weather ->
                    Log.e("WeatherViewModel,",weather.description)
                    weather.level }

    }

    fun refreshWeather(id: Int): Completable {
        return CompletableFromAction(Action { mRepository.refreshWeather(id) })
    }
}
