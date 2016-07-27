package test.wiredcraft.whitecomet.barcoder.wbarcoder.utils;

import java.io.IOException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * For send http request to server, receive response back.
 * @version 0.1.
 * @author shiyinayuriko
 */
public class Network {
    private OkHttpClient client = new OkHttpClient();

    /**
     * Send a http get request synchronously.
     * @param url The target url to request.
     * @return The content of the response body.
     * @throws IOException
     */
    public String getSync(String url) throws IOException {
        Request request = new Request.Builder().url(url).build();
        Response response = client.newCall(request).execute();
        if(!response.isSuccessful())
            throw new IOException("Unexpected code " + response.toString());
        return response.body().string();
    }

    /**
     * Send a http get request asynchronously.
     * @param url The target url to request.
     * @param callback The callback when the response is returned.
     * @throws IOException
     */
    public void getAsync(String url, final GetAsyncCallback callback) throws IOException {
        Request request = new Request.Builder().url(url).build();
//        Response response = client.newCall(request).execute();
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

    /**
     * The callback getAsync() called.
     * @see #getAsync(String, GetAsyncCallback)
     */
    public interface GetAsyncCallback {
        void onResponse(String string, IOException e);
    }
}
