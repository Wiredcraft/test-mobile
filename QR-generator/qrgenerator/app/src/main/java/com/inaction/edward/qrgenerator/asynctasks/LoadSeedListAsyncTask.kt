package com.inaction.edward.qrgenerator.asynctasks

import android.os.AsyncTask
import com.inaction.edward.qrgenerator.database.AppDatabase
import com.inaction.edward.qrgenerator.entities.Seed

class LoadSeedListAsyncTask(callback: (List<Seed>) -> Unit): AsyncTask<Unit, Unit, List<Seed>>() {

    private val mCallback = callback

    override fun onPostExecute(result: List<Seed>?) {
        super.onPostExecute(result)
        result?.let{
            mCallback(it)
        }
    }

    override fun doInBackground(vararg params: Unit?): List<Seed> {
        return AppDatabase.appDataBase.seedDao().getAll()
    }

}
