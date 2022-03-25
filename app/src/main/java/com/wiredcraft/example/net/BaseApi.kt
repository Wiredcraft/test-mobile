package com.hp.marykay.net

import com.hp.marykay.net.converter.RxErrorHandlingCallAdapterFactory
import com.wiredcraft.example.BuildConfig
import com.wiredcraft.example.net.converter.NullOnEmptyConverterFactory
import com.wiredcraft.example.net.interceptor.LogInterceptor
import okhttp3.*
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.security.SecureRandom
import java.security.cert.X509Certificate
import java.util.concurrent.TimeUnit
import javax.net.ssl.HostnameVerifier
import javax.net.ssl.SSLContext
import javax.net.ssl.TrustManager
import javax.net.ssl.X509TrustManager

open class BaseApi {
    val READ_TIMEOUT_DEFAULT = 30
    val CONNECT_TIMEOUT_DEFAULT = 30

    private fun getBuilder(): OkHttpClient.Builder {

        val builder = getSimpleBuilder()

        if (BuildConfig.DEBUG){
            //LogInterceptor 最后添加
            builder.addInterceptor(LogInterceptor())
        }

        return builder
    }

    private fun getSimpleBuilder(interceptor: Interceptor? = null): OkHttpClient.Builder {
        val builder = OkHttpClient.Builder()
            .readTimeout(READ_TIMEOUT_DEFAULT.toLong(), TimeUnit.SECONDS)
            .connectTimeout(CONNECT_TIMEOUT_DEFAULT.toLong(), TimeUnit.SECONDS)

        if (interceptor != null) {
            builder.addInterceptor(interceptor)
        }

        if (BuildConfig.DEBUG) {
            builder.apply {
                val naiveTrustManager = object : X509TrustManager {
                    override fun getAcceptedIssuers(): Array<X509Certificate> = arrayOf()
                    override fun checkClientTrusted(
                        certs: Array<X509Certificate>,
                        authType: String
                    ) = Unit

                    override fun checkServerTrusted(
                        certs: Array<X509Certificate>,
                        authType: String
                    ) = Unit
                }

                val insecureSocketFactory = SSLContext.getInstance("TLSv1.2").apply {
                    val trustAllCerts = arrayOf<TrustManager>(naiveTrustManager)
                    init(null, trustAllCerts, SecureRandom())
                }.socketFactory

                sslSocketFactory(insecureSocketFactory, naiveTrustManager)
                hostnameVerifier(HostnameVerifier { _, _ -> true })
            }
        }

        return builder
    }

    fun getRetrofitBuilder(url:String="https://api.github.com/"): Retrofit.Builder {
        return Retrofit.Builder()
            .baseUrl(url)
            .client(getBuilder().build())
            .addConverterFactory(NullOnEmptyConverterFactory())
            .addCallAdapterFactory(RxErrorHandlingCallAdapterFactory.create())
            .addConverterFactory(GsonConverterFactory.create())
    }

    companion object {
        const val TAG = "API_LOG"
    }

}