package test.wiredcraft.whitecomet.barcoder.wbarcoder.utils;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class Network {
    private OkHttpClient client = new OkHttpClient();

    public String getSync(String url) throws IOException {
        Request request = new Request.Builder().url(url).build();
        Response response = client.newCall(request).execute();
        if(!response.isSuccessful())
            throw new IOException("Unexpected code " + response.toString());
        return response.body().string();
    }

    public void getAsync(String url, final GetAsyncCallback callback) throws IOException {
        Request request = new Request.Builder().url(url).build();
        Response response = client.newCall(request).execute();
        client.newCall(request).enqueue(new Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                callback.onResponse(null,e);
            }
            @Override
            public void onResponse(Call call, Response response) throws IOException {
                if(!response.isSuccessful())
                    callback.onResponse(null, new IOException("Unexpected code " + response.toString()));
                else
                    callback.onResponse(response.body().string(), null);
            }
        });
    }
    public interface GetAsyncCallback {
        void onResponse(String string, IOException e);
    }
}
