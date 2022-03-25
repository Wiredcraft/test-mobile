package com.wiredcraft.example.config

/**
 * domain 配置
 */
class BaseEndpoint : ConfigurationEndpoint() {
    lateinit var queryUser: String
    lateinit var follow: String
    lateinit var getRepo: String
}