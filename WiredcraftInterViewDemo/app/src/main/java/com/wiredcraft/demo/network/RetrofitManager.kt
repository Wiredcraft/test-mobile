package com.wiredcraft.demo.network

import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.security.cert.CertificateException
import java.security.cert.X509Certificate
import java.util.concurrent.TimeUnit
import javax.net.ssl.SSLContext
import javax.net.ssl.SSLSocketFactory
import javax.net.ssl.TrustManager
import javax.net.ssl.X509TrustManager

object RetrofitManager {
    private var retrofitBuilder: Retrofit.Builder

    private const val BASE_URL = "https://api.github.com/"
    private const val DEFAULT_READ_TIMEOUT_MILLIS = 30 * 1000.toLong()
    private const val DEFAULT_WRITE_TIMEOUT_MILLIS = 30 * 1000.toLong()
    private const val DEFAULT_CONNECT_TIMEOUT_MILLIS = 20 * 1000.toLong()

    init {
        val okHttpClient = OkHttpClient.Builder()
            .readTimeout(DEFAULT_READ_TIMEOUT_MILLIS, TimeUnit.MILLISECONDS)
            .writeTimeout(DEFAULT_WRITE_TIMEOUT_MILLIS, TimeUnit.MILLISECONDS)
            .connectTimeout(DEFAULT_CONNECT_TIMEOUT_MILLIS, TimeUnit.MILLISECONDS)
            .hostnameVerifier { _, _ -> true }
            .sslSocketFactory(getSSLFactory())
            .build()

        retrofitBuilder = Retrofit.Builder()
            .client(okHttpClient)
            .addConverterFactory(GsonConverterFactory.create())
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
    }

    fun <T> create(service: Class<T>): T {
        return retrofitBuilder.baseUrl(BASE_URL).build().create(service)
    }

    private fun getSSLFactory(): SSLSocketFactory {
        val trustAllCerts = arrayOf<TrustManager>(object : X509TrustManager {
            override fun getAcceptedIssuers(): Array<X509Certificate> {
                return arrayOf()
            }

            @Throws(CertificateException::class)
            override fun checkClientTrusted(
                chain: Array<X509Certificate>,
                authType: String
            ) {
            }

            @Throws(CertificateException::class)
            override fun checkServerTrusted(
                chain: Array<X509Certificate>,
                authType: String
            ) {
            }
        })

        val sslContext = SSLContext.getInstance("SSL")
        sslContext.init(null, trustAllCerts, java.security.SecureRandom())
        return sslContext.socketFactory
    }
}
