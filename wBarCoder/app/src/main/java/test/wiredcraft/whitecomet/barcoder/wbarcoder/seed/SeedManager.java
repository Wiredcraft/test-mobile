package test.wiredcraft.whitecomet.barcoder.wbarcoder.seed;

import android.content.Context;
import android.content.SharedPreferences;
import android.widget.Toast;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.Network;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.WcLog;

public class SeedManager {
    //TODO URL
    private static final String TAG = SeedManager.class.getSimpleName();
    private static final String SEED_URL = "";
    private static final String SEED_PREFERENCE_NAME = "pref_seed";
    private static final String SEED_PREFERENCE_KEY_SEED = "seed";
    private static final String SEED_PREFERENCE_KEY_EXPIREDTIME = "expired_time";



    private static SeedManager instantce = null;
    public static SeedManager getInstantce(Context context){
        if (instantce == null) instantce = new SeedManager(context);
        return instantce;
    }

    private Context context;
    private final Network network;
    private SeedManager(Context context){
        this.context = context;
        network = new Network();
        preferences = context.getSharedPreferences(SEED_PREFERENCE_NAME, Context.MODE_PRIVATE);
        seedRefreshedCallbacks = new HashSet<>();
    }


    public interface SeedRefreshedCallback{
        void onRefresh(Seed seed);
    }
    private Set<SeedRefreshedCallback> seedRefreshedCallbacks;
    public void registerRefreshCallback(SeedRefreshedCallback callback){
        seedRefreshedCallbacks.add(callback);
    }
    public void unregisterRefreshCallback(SeedRefreshedCallback callback){
        seedRefreshedCallbacks.remove(callback);
    }

    public void refreshSeed(){
        try {
            network.getAsync(SEED_URL, networkCallback);
        } catch (IOException e) {
            WcLog.e(TAG,"refreshSeed request failed", e);
            Toast.makeText(context,"Refresh seed failed",Toast.LENGTH_LONG).show();
        }
    }

    private Network.GetAsyncCallback networkCallback = new Network.GetAsyncCallback() {
        @Override
        public void onResponse(String string, IOException e) {
            if(e != null){
                WcLog.e(TAG,"refreshSeed request error", e);
                Toast.makeText(context,"Refresh seed failed",Toast.LENGTH_LONG).show();
            }

            try {
                Seed newSeed = new Gson().fromJson(string, Seed.class);
                if( newSeed == null ) throw new JsonSyntaxException("json string is null");
                saveSeed(newSeed);

                for (SeedRefreshedCallback callback:seedRefreshedCallbacks){
                    callback.onRefresh(newSeed);
                }

            }catch (JsonSyntaxException e1){
                WcLog.e(TAG,"json string error:" + string, e);
            }

        }
    };

    private SharedPreferences preferences;
    public synchronized Seed loadSeed(){
        String seedStr = preferences.getString(SEED_PREFERENCE_KEY_SEED, null);
        long expiredTime = preferences.getLong(SEED_PREFERENCE_KEY_EXPIREDTIME, 0);
        if(seedStr == null) return null;
        else return new Seed(seedStr,expiredTime);
    }
    public synchronized void saveSeed(Seed seed){
        SharedPreferences.Editor editor = preferences.edit();
        editor.putString(SEED_PREFERENCE_KEY_SEED,seed.getSeed());
        editor.putLong(SEED_PREFERENCE_KEY_EXPIREDTIME,seed.getExpiredTime());
        editor.commit();
    }
}
