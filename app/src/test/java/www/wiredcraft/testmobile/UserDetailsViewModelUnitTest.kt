package www.wiredcraft.testmobile

import android.app.Application
import androidx.databinding.ObservableField
import com.google.gson.Gson
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import www.wiredcraft.testmobile.api.model.Item
import www.wiredcraft.testmobile.api.model.ReposData
import www.wiredcraft.testmobile.viewmodel.UserDetailsViewModel

/**
 *@Description:
 * #
 * #0000      @Author: tianxiao     2022/4/1      onCreate
 */
class UserDetailsViewModelUnitTest {

    @Mock
    lateinit var mockApplicationContext: Application
    @Mock
    lateinit var vm :UserDetailsViewModel
    @Mock
    lateinit var data :ReposData
    @Mock
    lateinit var gson :Gson

    @Before
    @Throws(Exception::class)
    fun setUp() {
        MockitoAnnotations.initMocks(this)
    }

    @Test
    fun test(){
        Assert.assertNotNull(gson)
        Assert.assertNotNull(mockApplicationContext)
        data.allow_forking = false
        data.archive_url ="https://api.github.com/search/users?q=swift&page=1"
        Assert.assertEquals(data.allow_forking, false)
        Assert.assertNotEquals(data.archive_url,"")
    }

    @Test
    fun userDataTset(){
        Assert.assertEquals(vm.userData,null)
    }
}