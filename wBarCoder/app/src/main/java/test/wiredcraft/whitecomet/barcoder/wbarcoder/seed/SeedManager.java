package test.wiredcraft.whitecomet.barcoder.wbarcoder.seed;

import android.content.Context;
import android.content.SharedPreferences;
import android.widget.Toast;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.Constant;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.Network;
import test.wiredcraft.whitecomet.barcoder.wbarcoder.utils.WcLog;

public class SeedManager {
    //TODO URL
    private static final String TAG = SeedManager.class.getSimpleName();
    private static final String DEFAULT_SEED_URL = Constant.SERVER_HOST;
    private static final String SEED_PREFERENCE_NAME = "pref_seed";
    private static final String SEED_PREFERENCE_KEY_SEED = "seed";
    private static final String SEED_PREFERENCE_KEY_EXPIREDTIME = "expired_time";


    private static SeedManager instance = null;
    public static SeedManager getInstance(Context context){
        if (instance == null) instance = new SeedManager(context);
        return instance;
    }

    private Context context;
    private final Network network;
    private SeedParser parser;
    private String seedUrl;
    private SeedManager(Context context){
        this.context = context;
        network = new Network();
        preferences = context.getSharedPreferences(SEED_PREFERENCE_NAME, Context.MODE_PRIVATE);
        seedRefreshedCallbacks = new HashSet<>();
        parser = new DefaultSeedParser();
        seedUrl = DEFAULT_SEED_URL;
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

    public void setSeedParser(SeedParser parser){
        this.parser = parser;
    }
    public void setSeedUrl(String url){
        seedUrl = url;
    }
    public void refreshSeed(){
        try {
            network.getAsync(seedUrl, networkCallback);
        } catch (Exception e) {
            WcLog.e(TAG,"refreshSeed request failed", e);
            Toast.makeText(context,"Refresh seed failed",Toast.LENGTH_LONG).show();
        }
    }

    private Network.GetAsyncCallback networkCallback = new Network.GetAsyncCallback() {
        @Override
        public void onResponse(String string, IOException e) {
            Seed newSeed = null;
            if(e != null){
                WcLog.e(TAG,"refreshSeed request error", e);
            }
            try {
                newSeed = parser.parse(string);
                if( newSeed == null ) throw new Exception("newSeed is null");
                saveSeed(newSeed);

            }catch (Exception e1){
                WcLog.e(TAG,"newSeed error:" + string, e1);
            }

            for (SeedRefreshedCallback callback:seedRefreshedCallbacks){
                callback.onRefresh(newSeed);
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

    public interface SeedParser{
        Seed parse(String json);
    }
}
