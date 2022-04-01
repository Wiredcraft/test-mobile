package www.wiredcraft.testmobile

import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import www.wiredcraft.testmobile.api.model.Item
import www.wiredcraft.testmobile.api.model.UserData
import www.wiredcraft.testmobile.viewmodel.UserDetailsViewModel

/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/4/1      onCreate
 */
class UserDetailsViewModelUnitTest {

    @Mock
    lateinit var vm :UserDetailsViewModel
    @Mock
    lateinit var data :UserData
    @Before
    @Throws(Exception::class)
    fun setUp() {
        MockitoAnnotations.initMocks(this)
    }

    @Test
    fun test(){
       // vm.userData.set()
    }
}