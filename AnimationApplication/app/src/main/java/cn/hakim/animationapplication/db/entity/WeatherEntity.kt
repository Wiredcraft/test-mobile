package cn.hakim.animationapplication.db.entity

import android.arch.persistence.room.ColumnInfo
import android.arch.persistence.room.Entity
import android.arch.persistence.room.PrimaryKey

import cn.hakim.animationapplication.model.Weather

/**
 * Created by Administrator on 2017/6/23.
 * SQlite实现方式，使用接口可以扩展出多种数据库实现方式
 */
@Entity(tableName = "weathers")
class WeatherEntity : Weather {
    @PrimaryKey
    @ColumnInfo(name = "id")
    override var id: Int = 0
    @ColumnInfo(name = "description")
    override var description: String = ""
    @ColumnInfo(name = "name")
    override var name: String = ""
    @ColumnInfo(name = "level")
    override var level: Int = 0
    @ColumnInfo(name = "type")
    override var type: Int = 0

    constructor(weather: Weather) {
        this.id = weather.id
        this.name = weather.name
        this.description = weather.description
        this.type = weather.type
        this.level = weather.level
    }

    constructor() {

    }
}
