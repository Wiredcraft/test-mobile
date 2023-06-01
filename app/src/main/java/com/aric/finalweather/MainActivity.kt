package com.aric.finalweather

import android.annotation.SuppressLint
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.NavController
import com.aric.finalweather.extentions.setupNavigationController
import com.gyf.immersionbar.ImmersionBar


class MainActivity : AppCompatActivity() {
    private lateinit var navController: NavController

    @SuppressLint("MissingInflatedId")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_container)
        ImmersionBar.with(this)
            .transparentStatusBar()
            .init()
        setupNavigationController(
            R.id.nav_host_fragment,
            R.navigation.nav_graph_github,
        ) {
            navController = it
        }
    }

    override fun onBackPressed() {
        if (!navController.navigateUp()) {
            finishAfterTransition()
        }
    }
}

