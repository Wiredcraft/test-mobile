package com.inaction.edward.qrgenerator

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import android.widget.TextView
import com.inaction.edward.qrgenerator.api.ApiClient
import com.inaction.edward.qrgenerator.entities.Seed
import net.glxn.qrgen.android.QRCode
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class GeneratorActivity : AppCompatActivity() {

    var qrCodeImageView: ImageView? = null
    var counterTextView: TextView? = null

    private var mSeed: Seed? = null

    companion object {
        const val SEED_KEY = "seed_data"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_generator)

        setupUi()

        // try to restore seed
        if (savedInstanceState != null) {
            mSeed = savedInstanceState.getParcelable<Seed>(SEED_KEY)
        }

        mSeed?.let {
            showSeed()
        } ?: kotlin.run {
            generateSeed()
        }
    }

    private fun setupUi() {
        qrCodeImageView = findViewById(R.id.qrCodeImageView)
        counterTextView = findViewById(R.id.counterTextView)
    }

    override fun onSaveInstanceState(outState: Bundle?) {
        super.onSaveInstanceState(outState)
        mSeed?.let { seed ->
            outState?.putParcelable(SEED_KEY, seed)
        }
    }

    override fun onResume() {
        super.onResume()

        mSeed?.let {
            showSeed()
        }
    }

    override fun onPause() {
        super.onPause()

        mSeed?.let {
            counterTextView?.removeCallbacks(counter)
        }
    }

    private fun generateSeed() {
        ApiClient.getSeedService().generateSeed().enqueue(object: Callback<Seed> {
            override fun onResponse(call: Call<Seed>?, response: Response<Seed>?) {
                val seed = response?.body()
                seed?.let {
                    mSeed = it
                    showSeed()
                } ?: kotlin.run {
                    toast(R.string.generate_error)
                    this@GeneratorActivity.finish()
                }
            }

            override fun onFailure(call: Call<Seed>?, t: Throwable?) {
                toast(R.string.generate_error)
                this@GeneratorActivity.finish()
            }
        })
    }

    private fun showSeed() {
        mSeed?.let {
            qrCodeImageView?.setImageBitmap(QRCode.from(it.data).bitmap())
            counterTextView?.post(counter)
        }
    }

    private val counter = object: Runnable {
        override fun run() {
            mSeed?. let {
                val currentTime = System.currentTimeMillis()
                val remainTime = it.expiredAt - currentTime
                if (remainTime > 0) {
                    counterTextView?.text = getString(R.string.counter_time, remainTime / 1000)
                    counterTextView?.postDelayed(this, 1000)
                } else {
                    generateSeed()
                }
            }
        }
    }
}
