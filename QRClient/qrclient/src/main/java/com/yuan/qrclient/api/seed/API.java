package com.yuan.qrclient.api.seed;

import com.yuan.qrclient.api.NetConfig;
import com.yuan.qrclient.model.Seed;

import java.io.IOException;

import retrofit.GsonConverterFactory;
import retrofit.Response;
import retrofit.Retrofit;
import retrofit.Call;

/**
 * Created by Yuan on 16/1/18.
 */
public class API {

    public static final String SERVERURL = NetConfig.SERVER + ":" + NetConfig.PORT + "/";

    /**
     * request the server to get seed
     * @return Seed
     * @throws IOException
     */
    public static SeedService seed_get() throws IOException {
        String baseurl = SERVERURL;
        Retrofit retrofit = new Retrofit.Builder()
                .addConverterFactory(GsonConverterFactory.create())
                .baseUrl(baseurl)
                .build();

        return retrofit.create(SeedService.class);
    }
}
