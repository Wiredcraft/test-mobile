package com.yuan.qrclient.ui.util;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * This class is used to save data to SharedPreferences
 *
 * Created by Yuan on 16/1/19.
 */
public class SpSetting {

    private static final String PACKAGE = "com.yuan.qrclient.ui.util";

    private static final String NAME = PACKAGE + ".seed";

    public static final String KEY_SEED_DATA = "data";

    public static final String KEY_EXPIREAT = "expiredAt";

    private SharedPreferences sharedPreferences;

    private SpSetting(Context context){
        this.sharedPreferences = context.getSharedPreferences(NAME,Context.MODE_PRIVATE);
    }

    public static SpSetting newInstance(Context context){
        return new SpSetting(context.getApplicationContext());
    }

    public void save(String key,String value){
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(key,value);
        editor.apply();
    }

    public void remove(String key){
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.remove(key);
        editor.commit();
    }

    public String getString(String key){
        return sharedPreferences.getString(key,null);
    }

    public void clear(){
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.clear();
        editor.commit();
    }
}
