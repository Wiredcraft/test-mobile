package com.lwjlol.github.user

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import coil.ImageLoader
import coil.compose.LocalImageLoader
import coil.request.CachePolicy
import com.lwjlol.github.user.ui.SearchInput
import com.lwjlol.github.user.ui.UserList
import com.lwjlol.github.user.ui.UserListViewModel
import com.lwjlol.github.user.ui.theme.GithubuserTheme

class MainActivity : ComponentActivity() {
    private val viewModel by viewModels<UserListViewModel>(factoryProducer = {
        UserListViewModel.Factory(UserListViewModel.State())
    })

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        LocalImageLoader.providesDefault(
            ImageLoader.Builder(this)
                .bitmapPoolingEnabled(true)
                .allowRgb565(true)
                .crossfade(true)
                .memoryCachePolicy(CachePolicy.ENABLED)
                .build()
        )
        setContent {
            GithubuserTheme {
                // A surface container using the 'background' color from the theme
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colors.background) {
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        SearchInput(viewModel)
                        UserList(viewModel)
                    }
                }
            }
        }
    }
}