/*
 * Copyright (C) 2017 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package cn.hakim.animationapplication

import android.content.Context


import cn.hakim.animationapplication.db.AppDataBase
import cn.hakim.animationapplication.db.LocalWeatherDataSource
import cn.hakim.animationapplication.viewmodel.WeatherModelFactory

/**
 * Enables injection of data sources.
 * 可通过Dagger注解管理dao对象获取数据或者网络对象获取数据
 */
object Injection {

    fun provideWeatherDataSource(context: Context): WeatherRepository {
        return WeatherRepository(context)
    }

    fun provideViewModelFactory(context: Context): WeatherModelFactory {
        val dataSource = provideWeatherDataSource(context)
        return WeatherModelFactory(dataSource)
    }
}
