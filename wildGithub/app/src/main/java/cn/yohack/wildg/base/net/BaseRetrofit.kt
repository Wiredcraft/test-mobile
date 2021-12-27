package cn.yohack.wildg.base.net

import cn.yohack.wildg.App
import cn.yohack.wildg.BuildConfig
import com.google.gson.GsonBuilder
import com.readystatesoftware.chuck.ChuckInterceptor
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

/**
 * @Author yo_hack
 * @Date 2021.12.27
 * @Description  base network api
 **/
abstract class BaseRetrofit(baseUrl: String) {

    private val retrofit: Retrofit by lazy {
        return@lazy enhanceRetrofitBuilder(
            Retrofit.Builder()
                .baseUrl(baseUrl)
                .client(okHttpClient)
                .addConverterFactory(GsonConverterFactory.create(GsonBuilder().create()))
        ).build()
    }

    /**
     * child can change some okhttp config
     */
    open fun enhanceHttpClientBuilder(builder: OkHttpClient.Builder): OkHttpClient.Builder = builder

    /**
     * child can change some retrofit config
     */
    open fun enhanceRetrofitBuilder(builder: Retrofit.Builder): Retrofit.Builder = builder

    /**
     * config http
     */
    private val okHttpClient: OkHttpClient
        get() {
            var builder = OkHttpClient.Builder()
                .connectTimeout(CONNECT_TIME_MILLIS, TimeUnit.MILLISECONDS)
                .readTimeout(READ_TIME_MILLIS, TimeUnit.MILLISECONDS)
                .writeTimeout(WRITE_TIME_MILLIS, TimeUnit.MILLISECONDS)
                .retryOnConnectionFailure(true)
//                .cache()

            builder = enhanceHttpClientBuilder(builder)

            // for debug only
            if (BuildConfig.DEBUG) {
                builder.addInterceptor(ChuckInterceptor(App.app))
                    .addInterceptor(HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BODY))
            }


            return builder.build()
        }


    fun <T> create(service: Class<T>): T {
        return retrofit.create(service)
    }
}