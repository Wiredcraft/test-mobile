package com.yuan.qrclient.ui.activity;

import android.os.Bundle;
import android.support.v7.widget.Toolbar;

import com.yuan.qrclient.R;

public class AboutActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about);
        initView();
    }

    protected void initView() {
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        toolbar.setNavigationOnClickListener(v -> supportFinishAfterTransition());
    }
}
