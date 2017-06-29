package cn.hakim.animationapplication.common

/**
 * Created by Administrator on 2017/6/23.
 */

enum class WeatherType private constructor(var nameStr: String, type: Int) {
    SUNSHINE("晴天", 0),
    RAIN("降雨", 1),
    SNOW("下雪", 2);

    var type: Int = 0

    companion object {

        fun getByCode(code: Int): WeatherType? {
            for (type in values()) {
                if (type.type == code) {
                    return type
                }
            }
            return null
        }
    }
}
