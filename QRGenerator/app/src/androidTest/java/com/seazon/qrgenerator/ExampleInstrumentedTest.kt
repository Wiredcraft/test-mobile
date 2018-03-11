package com.seazon.qrgenerator

import android.support.test.InstrumentationRegistry
import android.support.test.runner.AndroidJUnit4
import com.seazon.qrgenerator.api.ApiManager
import com.seazon.qrgenerator.entity.Seed

import org.junit.Test
import org.junit.runner.RunWith

import org.junit.Assert.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.io.IOException

/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
@RunWith(AndroidJUnit4::class)
class ExampleInstrumentedTest {
    @Test
    fun useAppContext() {
        // Context of the app under test.
        val appContext = InstrumentationRegistry.getTargetContext()
        assertEquals("com.seazon.qrgenerator", appContext.packageName)
    }

    @Test
    fun getSeedApi() {
        ApiManager.getInstence().getApiService().getSeed().enqueue(object : Callback<Seed> {
            override fun onResponse(call: Call<Seed>, response: Response<Seed>) {
                try {
                    assertNotNull(response.body()::class)
                    assertEquals(response.body()::class, Seed::class)
                } catch (e: IOException) {
                    e.printStackTrace()
                }
            }

            override fun onFailure(call: Call<Seed>, t: Throwable) {
                t.printStackTrace()
            }
        })
    }
}
