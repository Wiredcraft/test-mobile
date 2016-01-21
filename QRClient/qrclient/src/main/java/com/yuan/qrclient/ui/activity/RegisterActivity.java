package com.yuan.qrclient.ui.activity;

import android.os.Bundle;
import android.widget.EditText;

import com.yuan.qrclient.R;

public class RegisterActivity extends BaseTitleActivity {

    private EditText usernameview;
    private EditText psdview;
    private EditText psdconfview;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.content_register);

        initView();

    }

    private void initView() {
        usernameview = (EditText) findViewById(R.id.username);
        psdview = (EditText) findViewById(R.id.psd);
        psdconfview = (EditText) findViewById(R.id.psd_conform);

        findViewById(R.id.btn_registeer).setOnClickListener(v -> {
            attempRegister();
        });
    }

    private void attempRegister(){
        int usernamelen = usernameview.getText().toString().length();
        int psdlen = psdview.getText().toString().length();
        if(usernamelen < 5 || usernamelen > 10){
            usernameview.setError("");
            return;
        }
        if(psdlen <6 || psdlen > 20){
            psdview.setError("");
            return;
        }
        if(!psdview.getText().toString().equals(psdconfview.getText().toString())){
            psdview.setError(null);
            psdconfview.setError(null);
            return;
        }
    }
}
