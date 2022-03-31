package xyz.mengxy.githubuserslist

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.SavedStateHandle
import dagger.hilt.android.AndroidEntryPoint
import xyz.mengxy.githubuserslist.databinding.ActivityMainBinding

/**
 * Created by Mengxy on 3/28/22.
 * main activity use FragmentContainerView to navigate fragments
 */
@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        DataBindingUtil.setContentView<ActivityMainBinding>(this, R.layout.activity_main)
    }
}