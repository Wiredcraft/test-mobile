package com.dorck.githuber.ui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.ui.Modifier
import androidx.lifecycle.ViewModelProvider
import com.dorck.githuber.ui.pages.home.HomeUsersViewModel
import com.dorck.githuber.ui.pages.home.Homepage
import com.dorck.githuber.ui.theme.GithuberTheme
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val homeViewModel: HomeUsersViewModel = ViewModelProvider(this)[HomeUsersViewModel::class.java]
        setContent {
            GithuberTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colors.background
                ) {
                   Homepage(viewModel = homeViewModel)
                }
            }
        }
    }
}