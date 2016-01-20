package com.yuan.qrclient.api.seed;

import com.yuan.qrclient.model.Seed;

import retrofit.Call;
import retrofit.http.GET;

/**
 * Created by Yuan on 16/1/18.
 */
public interface SeedService {

    @GET("seed")
    Call<Seed> seed();
}
