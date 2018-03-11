package com.seazon.qrgenerator.ui

import android.content.Context
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import com.google.gson.Gson
import com.seazon.qrgenerator.R
import com.seazon.qrgenerator.api.ApiManager
import com.seazon.qrgenerator.entity.Seed
import com.seazon.qrgenerator.utils.CommonUtils
import com.uuzuche.lib_zxing.activity.CodeUtils
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.content_generate.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.io.IOException

/**
 * Created by seazon on 2018/3/7.
 */
class GenerateActivity : AppCompatActivity() {

    private val TAG = GenerateActivity::class.java.simpleName
    private val SHARED_PREFS_SEED_CACHE = "seed_cache"
    private val SHARED_PREFS_SEED_CACHE_KEY = "cache"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_generate)
        setSupportActionBar(toolbar)
    }

    override fun onStart() {
        Log.d(TAG, "onStart")
        super.onStart()
        getSeed()
    }

    override fun onStop() {
        super.onStop()
        timeView.stop()
    }

    private fun getSeed() {
        Log.d(TAG, "getSeed")
        ApiManager.getInstence().getApiService().getSeed().enqueue(object : Callback<Seed> {
            override fun onResponse(call: Call<Seed>, response: Response<Seed>) {
                try {
                    onSeedReceived(response.body())
                } catch (e: IOException) {
                    e.printStackTrace()
                    onSeedFetchFailed()
                }
            }

            override fun onFailure(call: Call<Seed>, t: Throwable) {
                t.printStackTrace()
                onSeedFetchFailed()
            }
        })
    }

    /**
     * cache seed and show qr with seed and fetch seed again when expired
     */
    private fun onSeedReceived(seed: Seed) {

        fun cacheSeed(seed: Seed) {
            val preferences = getSharedPreferences(SHARED_PREFS_SEED_CACHE, Context.MODE_PRIVATE)
            preferences?.edit()?.putString(SHARED_PREFS_SEED_CACHE_KEY, Gson().toJson(seed))?.apply()
        }

        cacheSeed(seed)
        val bitmap = CodeUtils.createImage(seed.seed, 400, 400, null)
        codeView.setImageBitmap(bitmap)
        timeView.start(seed.expires_at_long, object : CountdownView.TicListener {
            override fun onFinish() {
                Log.d(TAG, "onFinish")
                getSeed()
            }
        })
    }

    /**
     * if load seed failed, use cached seed, and don't fetch again after expired
     */
    private fun onSeedFetchFailed() {

        fun loadCachedSeed(): Seed {
            val sp = getSharedPreferences(SHARED_PREFS_SEED_CACHE, Context.MODE_PRIVATE)
            return Gson().fromJson(sp.getString(SHARED_PREFS_SEED_CACHE_KEY, null), Seed::class.java)
        }

        Log.w(TAG, "onSeedFetchFailed")
        val seed = loadCachedSeed()
        val bitmap = CodeUtils.createImage(seed.seed, 400, 400, null)
        codeView.setImageBitmap(bitmap)
        timeView.start(seed.expires_at_long, object : CountdownView.TicListener {
            override fun onFinish() {
                Log.d(TAG, "onFinish")
                timeView.text = CommonUtils.showCountdown(0)
            }
        })
    }

}