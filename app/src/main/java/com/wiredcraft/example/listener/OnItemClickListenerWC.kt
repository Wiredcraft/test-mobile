package com.wiredcraft.example.listener

import com.makeramen.roundedimageview.RoundedImageView

interface OnItemClickListenerWC<T> {
    fun onClick(item: T, imageView: RoundedImageView)
}