package com.yuan.qrclient.model;

/**
 * Created by Yuan on 16/1/18.
 */
public class Seed {

    public String data;

    public int len;

    public String expiredAt;

    @Override
    public String toString() {
        return "Seed{" +
                "data='" + data + '\'' +
                ", len=" + len +
                ", expiredAt='" + expiredAt + '\'' +
                '}';
    }
}
