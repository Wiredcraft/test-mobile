package com.aric.finalweather.base

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.navigation.fragment.NavHostFragment
class WindowNavHostFragment : NavHostFragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {

        val frameLayout = WindowFrameLayout(inflater.context)
        frameLayout.id = id
        return frameLayout
    }
}