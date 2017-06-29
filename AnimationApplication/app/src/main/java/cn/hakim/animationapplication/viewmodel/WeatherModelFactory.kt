package cn.hakim.animationapplication.viewmodel

import android.arch.lifecycle.ViewModel
import android.arch.lifecycle.ViewModelProvider

import cn.hakim.animationapplication.WeatherRepository

/**
 * Created by Administrator on 2017/6/26.
 */

class WeatherModelFactory(private val mDataRepo: WeatherRepository) : ViewModelProvider.Factory {

    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(WeatherViewModel::class.java!!)) {
            return WeatherViewModel(mDataRepo) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}
