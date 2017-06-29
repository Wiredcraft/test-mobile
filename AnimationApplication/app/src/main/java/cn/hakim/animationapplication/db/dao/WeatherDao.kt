package cn.hakim.animationapplication.db.dao

import android.arch.lifecycle.LiveData
import android.arch.persistence.room.Dao
import android.arch.persistence.room.Insert
import android.arch.persistence.room.OnConflictStrategy
import android.arch.persistence.room.Query

import cn.hakim.animationapplication.db.entity.WeatherEntity
import cn.hakim.animationapplication.model.Weather
import io.reactivex.Flowable
import io.reactivex.Observable

/**
 * Created by Administrator on 2017/6/23.
 */
@Dao
interface WeatherDao {

    //    @Query("SELECT * FROM weathers")
    //    LiveData<List<WeatherEntity>> getAll();

    //    @Query("select * from weathers where id = :id")
    //    LiveData<WeatherEntity> loadWeather(int weatherId);

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(entities: List<WeatherEntity>)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(weather: WeatherEntity)
//NOTICE : 使用kapt时有一个bug（可通过gradlew build --info 查看编译错误信息message view默认不显示）本来weatherId作为占位符被编译成了arg0，导致kapt编译出错。
    @Query("SELECT * FROM weathers where id = :arg0")
    fun loadWeatherSync(arg0: Int): Flowable<WeatherEntity>

    @get:Query("SELECT * FROM weathers")
    val all: Flowable<List<WeatherEntity>>

    //    @Query("select * from weathers where id = :weatherId")
    //    Observable<WeatherEntity> loadWeather(int weatherId);
}
