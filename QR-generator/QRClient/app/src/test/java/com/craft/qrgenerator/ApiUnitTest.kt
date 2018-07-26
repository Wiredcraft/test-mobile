package com.craft.qrgenerator

import com.craft.qrgenerator.api.ApiClient
import com.craft.qrgenerator.bean.SeedBean
import org.junit.Assert
import org.junit.Test
import retrofit2.Response


class ApiUnitTest {

    @Test
    fun seedServerTest() {
        val response: Response<SeedBean> = ApiClient.get().getApiService().getSeed().execute()
        if (response.isSuccessful) {
            response.body() ?: Assert.fail("There is no data in response!")
            val data = response.body()
            if (data == null) {
                Assert.fail("Data in seed is null")
            }
            System.out.println(data)
        } else {
            Assert.fail("Is the server running?")
        }
    }

}
