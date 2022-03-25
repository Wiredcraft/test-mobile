package com.wiredcraft.example.config

enum class EnvironmentEnum {
    DEV {
        override fun environmentIndex() = 0
        override fun environmentCode() = "dev"
        override fun environmentName() = "DEV 环境"
    },
    QA {
        override fun environmentIndex() = 1
        override fun environmentCode() = "qa"
        override fun environmentName() = "QA 环境"
    },
    UAT {
        override fun environmentIndex() = 2
        override fun environmentCode() = "uat"
        override fun environmentName() = "UAT 环境"
    },
    PROD {
        override fun environmentIndex() = 3
        override fun environmentCode() = "prod"
        override fun environmentName() = "PROD 环境"
    },
    UPDATE_QA {
        override fun environmentIndex() = 4
        override fun environmentCode() = "qa"
        override fun environmentName() = "强制更新测试 QA 环境"
    },
    STG {
        override fun environmentIndex() = 5
        override fun environmentCode() = "stg"
        override fun environmentName() = "STG 环境"
    };

    abstract fun environmentIndex(): Int
    abstract fun environmentCode(): String
    abstract fun environmentName(): String
}