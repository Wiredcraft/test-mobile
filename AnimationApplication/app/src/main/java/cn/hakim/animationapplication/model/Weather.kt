package cn.hakim.animationapplication.model

/**
 * Created by Administrator on 2017/6/23.
 * 雨的描述信息有：
 * id
 * 名称name：（阵雨，多云，中雪……）
 * 类型type：（1：多云，2：阵雨……）
 * 描述description：（降雨量50ml……）
 * 等级level：（七级大风……）
 */

interface Weather {
    val id: Int
    val description: String
    val name: String
    val level: Int
    val type: Int
}
