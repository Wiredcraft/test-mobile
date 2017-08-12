package com.inaction.edward.qrgenerator.adapters

import android.graphics.Color
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import com.inaction.edward.qrgenerator.R
import com.inaction.edward.qrgenerator.entities.Seed

class SeedAdapter(seedList: List<Seed>): RecyclerView.Adapter<SeedAdapter.ViewHolder>() {

    private val mSeedList = seedList

    override fun getItemCount(): Int {
        return mSeedList.size
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {

        val view = LayoutInflater.from(parent.context).inflate(R.layout.item_seed, parent, false)
        val viewHolder = ViewHolder(view)

        return viewHolder
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val seed = mSeedList[position]
        if (seed.type == 0) {
            holder.typeImageView?.setImageResource(R.drawable.ic_qrcode)
        } else {
            holder.typeImageView?.setImageResource(R.drawable.ic_scan)
        }
        holder.typeImageView?.setColorFilter(Color.GRAY)

        holder.dataTextView?.text = seed.data
    }

    class ViewHolder(itemView: View): RecyclerView.ViewHolder(itemView) {

        var typeImageView: ImageView? = null
        var dataTextView: TextView? = null

        init {
            typeImageView = itemView.findViewById(R.id.typeImageView)
            dataTextView = itemView.findViewById(R.id.dataTextView)
        }
    }

}


