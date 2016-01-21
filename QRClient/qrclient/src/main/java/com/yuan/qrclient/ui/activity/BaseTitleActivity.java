package com.yuan.qrclient.ui.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.FrameLayout;

import com.yuan.qrclient.R;

/**
 * Created by Yuan on 16/1/15.
 */
public abstract class BaseTitleActivity extends BaseActivity {

    private Toolbar toolbar;
    private FrameLayout content;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        super.setContentView(R.layout.activity_title_root);
        init();
    }

    @Override
    public void setContentView(int layoutResID) {
        content.addView(getLayoutInflater().inflate(layoutResID, null));
    }

    @Override
    public void setContentView(View view) {
        content.addView(view);
    }

    private void init() {
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        toolbar.setNavigationOnClickListener(v -> supportFinishAfterTransition());

        content = (FrameLayout) findViewById(R.id.lay_content);
    }

    protected Toolbar getTitleBar() {
        return toolbar;
    }

    @Override
    public void startActivity(Intent intent) {
        super.startActivity(intent);
    }
}
