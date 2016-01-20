package com.yuan.qrclient.ui.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;

import com.yuan.qrclient.R;

public class StartActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        anim();
        setContentView(R.layout.activity_start);
        new Handler().postDelayed(() -> {
            startActivity(new Intent(StartActivity.this, MainActivity.class));
            finish();
        }, 1000);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        anim();
    }

    private void anim(){
        overridePendingTransition(R.anim.activity_enter, R.anim.activity_exit);
    }
}
