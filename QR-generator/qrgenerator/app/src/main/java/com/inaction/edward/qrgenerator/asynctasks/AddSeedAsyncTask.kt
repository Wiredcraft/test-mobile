package com.inaction.edward.qrgenerator.asynctasks

import android.os.AsyncTask
import com.inaction.edward.qrgenerator.database.AppDatabase
import com.inaction.edward.qrgenerator.entities.Seed

class AddSeedAsyncTask: AsyncTask<Seed, Unit, Unit>() {

    override fun doInBackground(vararg seed: Seed): Unit {
        if (seed.isNotEmpty()) {
            AppDatabase.appDataBase.seedDao().insert(seed[0])
        }
    }

}
