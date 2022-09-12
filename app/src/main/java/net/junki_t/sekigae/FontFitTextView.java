package net.junki_t.sekigae;

import android.content.Context;
import android.graphics.Paint;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.widget.TextView;

/**
 * サイズ自動調整TextView
 * Copy from https://gist.github.com/STAR-ZERO/2934490
 */
public class FontFitTextView extends TextView {

    /** 最小のテキストサイズ */
    private static final float MIN_TEXT_SIZE = 2f;

    /**
     * コンストラクタ
     * @param context
     */
    public FontFitTextView(Context context) {
        super(context);
    }

    /**
     * コンストラクタ
     * @param context
     * @param attrs
     */
    public FontFitTextView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);

        resize();

    }

    /**
     * テキストサイズ調整
     */
    private void resize() {

        Paint paint = new Paint();

        // Viewの幅
        int viewWidth = this.getWidth();
        // テキストサイズ
        float textSize = getTextSize();

        // Paintにテキストサイズ設定
        paint.setTextSize(textSize);
        // テキストの横幅取得
        float textWidth = paint.measureText(this.getText().toString());

        while (viewWidth <  textWidth) {
            // 横幅に収まるまでループ

            if (MIN_TEXT_SIZE >= textSize) {
                // 最小サイズ以下になる場合は最小サイズ
                textSize = MIN_TEXT_SIZE;
                break;
            }

            // テキストサイズをデクリメント
            textSize--;

            // Paintにテキストサイズ設定
            paint.setTextSize(textSize);
            // テキストの横幅を再取得
            textWidth = paint.measureText(this.getText().toString());

        }

        // テキストサイズ設定
        setTextSize(TypedValue.COMPLEX_UNIT_PX, textSize);
    }
}