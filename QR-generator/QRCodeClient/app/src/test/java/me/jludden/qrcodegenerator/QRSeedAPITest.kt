package me.jludden.qrcodegenerator

import io.reactivex.observers.TestObserver
import junit.framework.Assert.assertTrue
import me.jludden.qrcodegenerator.QRSeedGeneratorAPI.QRSeedGenAPI
import me.jludden.qrcodegenerator.QRSeedGeneratorAPI.SeedResult
import org.junit.Test
import java.util.regex.Pattern

class QRSeedAPITest {
    @Test
    fun apiCall_succeeds() {
        val seedAPI = QRSeedGenAPI.create()
        val testSubscriber = TestObserver<SeedResult>()
        seedAPI.getQRseed().subscribe(testSubscriber)

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