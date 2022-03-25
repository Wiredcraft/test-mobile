package com.wiredcraft.example.config

/**
 * @author 武玉朋
 * 全局Setting
 */
object GlobalSettings {

    lateinit var endpointGetter: () -> BaseEndpoint

    val endpoint: BaseEndpoint
        get() {
            return endpointGetter()
        }

    /**
     * 初始化，配置BaseEndpoint
     */
    fun init() {
        endpointGetter = { ConfigurationManager.config() }
    }
}