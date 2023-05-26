package com.aric.finalweather

import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.RecyclerView

class MainActivity : AppCompatActivity() {
    private lateinit var viewModel: MainActivityViewModel
    private lateinit var weatherList: RecyclerView
    private lateinit var userListAdapter: UserListAdapter
    @SuppressLint("MissingInflatedId")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        viewModel = ViewModelProvider(this)[MainActivityViewModel::class.java]
        userListAdapter = UserListAdapter()
        weatherList = findViewById<RecyclerView>(R.id.userList).apply {
            adapter = userListAdapter
        }
        viewModel.searchUsersByName("swift")
        viewModel.searchResult.observe(this) {
            userListAdapter.submitList(it)
        }
    }
}

