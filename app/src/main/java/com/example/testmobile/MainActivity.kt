package com.example.testmobile

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import com.example.testmobile.databinding.ActivityMainBinding
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {

    private val homeViewModel: HomeViewModel by viewModels()
    private lateinit var viewDataBinding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewDataBinding = ActivityMainBinding.inflate(layoutInflater, null, false).apply {
            viewModel = homeViewModel
        }
        viewDataBinding.lifecycleOwner = this
        setContentView(viewDataBinding.root)

        viewDataBinding.rv.adapter = GithubUserAdapter(homeViewModel, this) { user ->
            user?.let {
                val intent = Intent(this, WebViewActivity::class.java)
                intent.putExtra("user",it)
                startActivity(intent)
            }
        }

        homeViewModel.initHomePageData()
    }
}