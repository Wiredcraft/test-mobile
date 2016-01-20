package com.yuan.qrclient.ui.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;

import com.yuan.qrclient.R;

public class MainActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        findViewById(R.id.ac_scan).setOnClickListener(view ->
                startActivity(new Intent(MainActivity.this, ScanerActivity.class)));
        findViewById(R.id.ac_generate).setOnClickListener(view ->
                startActivity(new Intent(MainActivity.this, QRCodeActivity.class)));
    }

}
