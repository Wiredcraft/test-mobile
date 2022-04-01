package www.wiredcraft.testmobile

import android.app.Application
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import www.wiredcraft.testmobile.api.model.UserData
import www.wiredcraft.testmobile.viewmodel.MainViewModel


/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/4/1      onCreate
 */

class MainViewModleUnitTest {

    @Mock
    lateinit var mockApplicationContext: Application
    @Mock
    lateinit var vm : MainViewModel
    @Mock
    lateinit var userData: UserData

    @Before
    @Throws(Exception::class)
    fun setUp() {
        MockitoAnnotations.initMocks(this)
    }


    @Test
    fun test() {
        Assert.assertNotNull(vm)
        Assert.assertNotNull(mockApplicationContext)
        userData.incomplete_results = false
        Assert.assertNotEquals(userData.incomplete_results ,true)
    }

    @Test
    fun pageTest(){
        Assert.assertEquals(vm.page,0)
    }

    @Test
    fun idTest(){
        Assert.assertEquals(vm.id,null)
    }

}