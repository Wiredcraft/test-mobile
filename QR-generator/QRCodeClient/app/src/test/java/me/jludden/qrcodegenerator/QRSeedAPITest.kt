package me.jludden.qrcodegenerator

import io.reactivex.observers.TestObserver
import junit.framework.Assert.assertTrue
import org.junit.Test
import java.util.regex.Pattern

class QRSeedAPITest {

    @Test
    fun apiCall_succeeds() {
        val testSubscriber = TestObserver<SeedResult>()
        val seedAPI = DaggerQrGenComponent.builder().build().apiService
        seedAPI.getSeedFromServer().subscribe(testSubscriber)

        val results : List<SeedResult> = testSubscriber.values()
        testSubscriber.assertNoErrors()
        testSubscriber.assertValueCount(1)
        testSubscriber.assertComplete()
        assertTrue(testSeedResults(results))
    }

    private fun testSeedResults(results: List<SeedResult>) : Boolean {
        assert(results.size == 1)
        val pattern = Pattern.compile("^[a-z0-9]*$")
        val seed = results[0]
        assertTrue(pattern.matcher(seed.seed).matches())
        return true
    }
}