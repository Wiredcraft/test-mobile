package com.wiredcraft.example.widget;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PixelFormat;
import android.graphics.drawable.Drawable;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;


public class ArcDrawable extends Drawable {

    private int mWidth;
    private int mHeight;
    private Paint mPaint;

    public ArcDrawable() {
        initPaint(Color.WHITE);
    }

    /**
     * 配置 不透明区域颜色.
     *
     * @param color getResources().getColor() ; 默认 : Color.WHITE.
     */
    public ArcDrawable(int color) {
        initPaint(color);
    }

    private void initPaint(int color) {
        mPaint = new Paint();
        mPaint.setColor(color);
        mPaint.setStrokeWidth(8);
        mPaint.setStyle(Paint.Style.FILL);
        mPaint.setAntiAlias(true);
    }

    @Override
    public void draw(@NonNull Canvas canvas) {
        canvas.drawColor(Color.TRANSPARENT);

        // 用 贝塞尔曲线绘制圆弧.
        Path path = new Path();
        float startX = 0;
        float startY = 0;
        float controlX = (float) mWidth / 2;
        float controlY = (float) mHeight;

        path.moveTo(startX, startY);
        path.lineTo(0, mHeight);
        path.lineTo(mWidth, mHeight);
        path.lineTo(mWidth,0);
        path.quadTo(controlX, controlY, startX, startY);
        canvas.drawPath(path, mPaint);
    }

    @Override
    public void setAlpha(int alpha) {

    }

    @Override
    public void setColorFilter(@Nullable ColorFilter colorFilter) {

    }

    @Override
    public int getOpacity() {
        return PixelFormat.TRANSLUCENT;
    }


    @Override
    public void setBounds(int left, int top, int right, int bottom) {
        super.setBounds(left, top, right, bottom);
        mWidth = right - left;
        mHeight = bottom - top;
    }
}
