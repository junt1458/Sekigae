package net.junki_t.sekigae;

import android.app.AlertDialog;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class SavePhotoActivity extends AppCompatActivity {

    ImageView normalview;
    ImageView hikinobashiview;
    static Bitmap img1;
    static Bitmap img2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_save_photo);
        normalview = (ImageView) findViewById(R.id.normalview);
        hikinobashiview = (ImageView) findViewById(R.id.hikinobashiview);
        select();
    }

    public static Bitmap loadBitmapFromView(View v){
        Bitmap b = Bitmap.createBitmap(v.getWidth(), v.getHeight(), Bitmap.Config.ARGB_8888);
        Canvas c = new Canvas(b);
        v.layout(0, 0, v.getWidth(), v.getHeight());
        v.draw(c);
        return b;
    }

    public void take(){
        RelativeLayout layout = (RelativeLayout) findViewById(R.id.spa);
        Bitmap photo = loadBitmapFromView(layout);
        try {
            savePhoto(photo);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void savePhoto(Bitmap bitmap) throws IOException {
        String saveDir = Environment.getExternalStorageDirectory().getPath() + "/savedPhoto";
        File folder = new File(saveDir);
        if(!folder.exists()) {
            if(!folder.mkdirs());
        }
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd_HHmmss");
        String imgPath = saveDir + "/" + sf.format(cal.getTime()) + ".jpg";
        if(bitmap == null);
        OutputStream fos;
        try {
            fos = new FileOutputStream(imgPath, true);
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fos);
            fos.flush();
            fos.close();
        } catch (Exception e){
        }
        ContentValues values = new ContentValues();
        ContentResolver contentResolver = this.getContentResolver();
        values.put(MediaStore.Images.Media.MIME_TYPE, "image/jpeg");
        values.put("_data", imgPath);
        contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
        //Toast.makeText(getApplicationContext(), "Success", Toast.LENGTH_SHORT).show();
    }

    public void select(){
        final SavePhotoActivity ins = this;
        new AlertDialog.Builder(this)
                .setTitle("写真に保存")
                .setMessage("どのように保存しますか？")
                .setPositiveButton("結果画面と同じようにして保存", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        normalview.setImageBitmap(img1);
                        take();
                        new AlertDialog.Builder(ins)
                                .setTitle("完了")
                                .setMessage("保存しました。")
                                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {
                                        ins.finish();
                                    }
                                })
                                .show();
                    }
                })
                .setNeutralButton("中央に寄せて保存", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        normalview.setImageBitmap(img2);
                        take();
                        new AlertDialog.Builder(ins)
                                .setTitle("完了")
                                .setMessage("保存しました。")
                                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {
                                        ins.finish();
                                    }
                                })
                                .show();
                    }
                })
                .setNegativeButton("引き伸ばして保存", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        hikinobashiview.setImageBitmap(img2);
                        take();
                        new AlertDialog.Builder(ins)
                                .setTitle("完了")
                                .setMessage("保存しました。")
                                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {
                                        ins.finish();
                                    }
                                })
                                .show();
                    }
                })
                .show();
    }
}
