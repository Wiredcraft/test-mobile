package com.wiredcraft.example.config

import com.blankj.utilcode.BuildConfig
import com.google.gson.Gson
import com.google.gson.JsonParser
import com.wiredcraft.example.BaseApplication
import org.apache.commons.io.IOUtils
import kotlin.system.exitProcess

/**
 * 配置类
 */
open class ConfigurationEndpoint {
    var env_pattern: HashMap<String, HashMap<String, String>>? = null

    /**
     * 环境设置,配置Json文件中的占位符替换
     */
    fun buildURLString(str: String): String {
        var result = str

        env_pattern?.let {
            it.forEach { (pattern, value) ->
                if (result.contains(pattern)) {
                    val env = EnvironmentEnum.PROD.environmentCode()//因为是demo，所以写死PROD
                    val replace = value[env] ?: value["default"] ?: env
                    result = result.replace(pattern, replace)
                }
            }
        }

        return result
    }

}

object ConfigurationManager {
    val MAP: HashMap<String, ConfigurationEndpoint> = HashMap()

    /**
     * 配置endPoint
     * @param urlString 可配置为server端的文件url进行动态更新
     */
    inline fun <reified T> config(urlString: String=""): T where T : ConfigurationEndpoint {
        val key = T::class.toString()
        val t = MAP[key] as? T
        t?.let {
            return it
        }

        var endpoint: T? = null

        if (BuildConfig.DEBUG) {
            // 测试内置配置是否合规
            val assetInputStream = BaseApplication.instance.assets.open("endpoint.json")
            val body = IOUtils.toString(assetInputStream, "UTF-8")
            endpoint = buildEndpoint<T>(body)
            if (endpoint == null) {
                System.err.println("内置文件格式不正常，需要更新")
                exitProcess(-1)
            }
        }

        var body: String? = null

        if (endpoint == null) {
            // 加载内置配置，不应该有异常情况
            val assetInputStream = BaseApplication.instance.assets.open("endpoint.json")
            body = IOUtils.toString(assetInputStream, "UTF-8")
            endpoint = buildEndpoint<T>(body)
            endpoint?.let {
                MAP[key] = it
            }
        }

        return endpoint ?: throw java.lang.RuntimeException()
    }

    inline fun <reified T> buildEndpoint(body: String): T? where T : ConfigurationEndpoint {
        var jsonObject = JsonParser.parseString(body).asJsonObject

        val endpoint = Gson().fromJson<T>(jsonObject, T::class.java)

        var endpointValid = true
        for (field in T::class.java.declaredFields) {
            try {
                field.isAccessible = true
                if (field.get(endpoint) == null) {
                    endpointValid = false
                    System.err.println("${T::class.java.simpleName}, 属性名称：${field.name} 未设置，请检查本地或远程配置文件是否更新")
                }
            } catch (e: IllegalAccessException) {
                e.printStackTrace()
            }
        }

        if (!endpointValid) {
            if (BuildConfig.DEBUG) {
                System.err.println( "发现无效的配置文件，请检查控制台")
            }
            return null
        }

        jsonObject.keySet().forEach {
            val value = jsonObject.get(it)
            if (value.isJsonPrimitive && value.asJsonPrimitive.isString) {

                val url = value.asString

                jsonObject.addProperty(it, endpoint.buildURLString(url))
            }
        }

        return Gson().fromJson<T>(jsonObject, T::class.java)
    }
}