package com.yuan.qrclient.ui.activity;

/**
 * Created by Yuan on 16/1/20.
 */
public interface ILoadData {

    /**
     * start to load data
     */
    void onStart();

    /**
     * is loading
     */
    void onLoading();

    /**
     * finish the load
     */
    void onFinish();

    /**
     * the error occur
     */
    void onError();
}
