package com.inaction.edward.qrgenerator

import com.inaction.edward.qrgenerator.api.ApiClient
import com.inaction.edward.qrgenerator.entities.Seed
import org.junit.Assert
import org.junit.Test
import retrofit2.Response

class ApiTest {

    @Test
    fun seedServerTest() {
        val response:Response<Seed> = ApiClient.getSeedService().generateSeed().execute()
        if (response.isSuccessful) {
            response.body() ?: Assert.fail("There is no data in response!")
            val data = response.body()?.data
            if (data?.length != 32) {
                Assert.fail("Data in seed is not right!")
            }
            System.out.println(response.body()?.data)
        } else {
            Assert.fail("Is the server running?")
        }
    }

}
