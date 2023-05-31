package com.wiredcraft.mobileapp

import com.wiredcraft.mobileapp.domain.UIState
import com.wiredcraft.mobileapp.domain.toUIState
import com.wiredcraft.mobileapp.ui.home.HomeActivityViewModel
import com.wiredcraft.mobileapp.ui.userdetail.UserDetailViewModel
import junit.framework.AssertionFailedError
import org.junit.Test

import org.junit.Assert.*

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
class ExampleUnitTest {

    @Test
    fun stateWhenException() {
        //error state
        val uiState = NullPointerException().toUIState<String>()
        if (uiState !is UIState.Error) {
            throw AssertionFailedError("state is Not in line with expectations")
        }
    }
}