package www.wiredcraft.testmobile

import android.app.Application
import androidx.test.core.app.ApplicationProvider
import com.zhouyou.http.EasyHttp
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import www.wiredcraft.testmobile.viewmodel.MainViewModel


/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/4/1      onCreate
 */

class MainViewModleUnitTest {

    @Mock
    private val mockApplicationContext: Application ?=null
    val vm = MainViewModel()
    val name = "kingkazma"
    val context = ApplicationProvider.getApplicationContext<Application>()

    @Before
    @Throws(Exception::class)
    fun setUp() {
        MockitoAnnotations.initMocks(this)
    }


    @Test
    fun test() {
        EasyHttp.init(context)
        vm.id = name
        Assert.assertEquals("kingkazma", vm.id)
        Assert.assertEquals(name, vm.id)
    }
}