package net.junki_t.sekigae;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.LinearLayout;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class ResultActivity extends AppCompatActivity {

    //Textview16 ~ TextView63 (-16でIndexと同じになるはず？)

    net.junki_t.sekigae.FontFitTextView[] tvs = new net.junki_t.sekigae.FontFitTextView[DataClass.CountLimit];
    PeopleInformation[] pi;
    int[] sd;
    Bitmap img1;
    Bitmap img2;

    public static Bitmap loadBitmapFromView(View v){
        Bitmap b = Bitmap.createBitmap(v.getWidth(), v.getHeight(), Bitmap.Config.ARGB_8888);
        Canvas c = new Canvas(b);
        v.layout(0, 0, v.getWidth(), v.getHeight());
        v.draw(c);
        return b;
    }

    public boolean isNotUse1retsu(int retsu){
        int x = 2 * (retsu - 1);
        int x2 = x + 1;
        int x3 = x + 16;
        int x4 = x + 17;
        int x5 = x + 32;
        int x6 = x + 33;
        if(!DataClass.sekistatus[x]
                && !DataClass.sekistatus[x2]
                && !DataClass.sekistatus[x3]
                && !DataClass.sekistatus[x4]
                && !DataClass.sekistatus[x5]
                && !DataClass.sekistatus[x6]) {
            return true;
        }
        return false;
    }

    public void del1retsu(int retsu){
        int x = 2 * (retsu - 1);
        int x2 = x + 1;
        int x3 = x + 16;
        int x4 = x + 17;
        int x5 = x + 32;
        int x6 = x + 33;
        tvs[x].setVisibility(View.INVISIBLE);
        tvs[x2].setVisibility(View.INVISIBLE);
        tvs[x3].setVisibility(View.INVISIBLE);
        tvs[x4].setVisibility(View.INVISIBLE);
        tvs[x5].setVisibility(View.INVISIBLE);
        tvs[x6].setVisibility(View.INVISIBLE);
    }

    public Bitmap getViewBitmap(View view){
        view.setDrawingCacheEnabled(true);
        Bitmap cache = view.getDrawingCache();
        if(cache == null){
            return null;
        }
        Bitmap bitmap = Bitmap.createBitmap(cache);
        view.setDrawingCacheEnabled(false);
        return bitmap;
    }

    public void photoSave(View view) {
        Intent intent = new Intent(this, SavePhotoActivity.class);
        //bm == img1
        SavePhotoActivity.img1 = img1;
        SavePhotoActivity.img2 = img2;
        startActivity(intent);
    }

    public Bitmap trimBitmap(Bitmap map, int maxretsu){
        Bitmap bm = Bitmap.createBitmap(map, 0, 0, map.getWidth(), map.getHeight() - (tvs[0].getHeight() * (8 - maxretsu)));
        return bm;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_result);
        Intent intent = getIntent();
        for(int i = 1; i < (DataClass.CountLimit + 1); i++){
            int id = getResources().getIdentifier("textView" + (i + 15), "id", getPackageName());
            tvs[i - 1] = (net.junki_t.sekigae.FontFitTextView) findViewById(id);
        }

        if(DataClass.Before_Data == null){
            //load before data.
            DataClass.Before_Data = new int[DataClass.CountLimit];
            for(int i = 0; i < DataClass.CountLimit; i++){
                DataClass.Before_Data[i] = -1;
            }
        }

        pi = DataClass.People_Data.clone();
        sd = DataClass.Seat_Data.clone();
        rottery2();
        changecolor();
        rotate();
        int maxretsu = 0;
        for(int i = 1; i < 9; i++){
            if(isNotUse1retsu(i)) {
                del1retsu(i);
            } else {
                if (maxretsu < i) {
                    maxretsu = i;
                }
            }
        }
        final LinearLayout layout = (LinearLayout) findViewById(R.id.lenearlayout);
        final int maxretsu2 = maxretsu;
        layout.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout(){
                layout.getViewTreeObserver().removeOnGlobalLayoutListener(this);
                Bitmap bm = loadBitmapFromView(layout);
                Bitmap bitmap;
                if(maxretsu2 != 8) {
                    bitmap = trimBitmap(bm, maxretsu2);
                } else {
                    bitmap = bm;
                }
                img1 = bm;
                img2 = bitmap;
            }
        });
    }

    public void rotate(){
        if(DataClass.rotateLabel){
            for(int i = 0; i < DataClass.CountLimit; i++){
                tvs[i].setRotationX (180);
                tvs[i].setRotationY (180);
            }
        }
    }

    public void changecolor(){
        if(DataClass.colorLabel){
            for(int i = 0; i < DataClass.CountLimit; i++){
                if(DataClass.sekistatus[i]) {
                    if (DataClass.m_wstatus[i]) {
                        tvs[i].setBackgroundResource(R.drawable.man);
                    } else {
                        tvs[i].setBackgroundResource(R.drawable.woman);
                    }
                }
            }
        }
    }

    @Override
    protected void onDestroy(){
        super.onDestroy();
        DataClass.People_Data = pi.clone();
        DataClass.Seat_Data = sd.clone();
    }

    public PeopleInformation[] getData(boolean isMan){
        int c = DataClass.woman;
        if(isMan){
            c = DataClass.man;
        }
        int nowc = 0;
        PeopleInformation[] pi = new PeopleInformation[c];
        for(int i = 0; i < DataClass.People_Data.length; i++){
            if(DataClass.People_Data[i].isMan == isMan) {
                pi[nowc] = DataClass.People_Data[i];
                nowc++;
            }
        }
        return pi;
    }

    public void rottery2(){
        List<PeopleInformation> manData = new ArrayList<PeopleInformation>();
        List<PeopleInformation> womanData = new ArrayList<PeopleInformation>();
        for(PeopleInformation data: getData(true)){
            manData.add(data);
        }
        for(PeopleInformation data: getData(false)){
            womanData.add(data);
        }
        for(int i = 0; i < DataClass.Seat_Data.length; i++){
            if(DataClass.Seat_Data[i] != -1){
                PeopleInformation human = DataClass.People_Data[DataClass.Seat_Data[i]];
                tvs[i].setText(human.Name);
                if(DataClass.m_wstatus[i]){
                    manData.remove(getArrayIndex(manData, human));
                } else {
                    womanData.remove(getArrayIndex(womanData, human));
                }
            }
        }

        for(int i = 0; i < tvs.length; i++){
            if(DataClass.sekistatus[i]) {
                if(DataClass.Seat_Data[i] == -1){
                    if(DataClass.m_wstatus[i]){
                        int index = new Random().nextInt(Integer.MAX_VALUE - 1) % manData.size();
                        int dcount = 0;
                        while(dcount < 10 && DataClass.Before_Data[i] == manData.get(index).AllNumber){
                            dcount++;
                            index = new Random().nextInt(Integer.MAX_VALUE - 1) % manData.size();
                        }
                        PeopleInformation human = manData.get(index);
                        tvs[i].setText(human.Name);
                        DataClass.Seat_Data[i] = human.AllNumber;
                        manData.remove(index);
                    } else {
                        int index = new Random().nextInt(Integer.MAX_VALUE - 1) % womanData.size();
                        int dcount = 0;
                        while(dcount < 10 && DataClass.Before_Data[i] == womanData.get(index).AllNumber){
                            dcount++;
                            index = new Random().nextInt(Integer.MAX_VALUE - 1) % womanData.size();
                        }
                        PeopleInformation human = womanData.get(index);
                        tvs[i].setText(human.Name);
                        DataClass.Seat_Data[i] = human.AllNumber;
                        womanData.remove(index);
                    }
                }
            } else {
                tvs[i].setText("");
                tvs[i].setBackgroundResource(R.drawable.nodesk);
            }
        }
    }

    public void oncemore(View v){
        this.finish();
        DataClass.People_Data = pi.clone();
        DataClass.Seat_Data = sd.clone();
        CheckActivity.ca.rottery(v);
    }

    public int getArrayIndex(List<PeopleInformation> datas, PeopleInformation data){
        for(int i = 0; i < datas.size(); i++){
            PeopleInformation d = datas.get(i);
            if(d.AllNumber == data.AllNumber && d.isMan == data.isMan && d.Number == data.Number){
                return i;
            }
        }
        return -1;
    }

    public void close(View v){
        final ResultActivity ins = this;
        new AlertDialog.Builder(this)
                .setTitle("終了")
                .setMessage("終了しますか？")
                .setPositiveButton("はい", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        new AlertDialog.Builder(ins)
                                .setTitle("確認")
                                .setMessage("今回のデータを保存しますか？")
                                .setPositiveButton("はい", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {
                                        DataClass.Before_Data = DataClass.Seat_Data.clone();
                                        DataClass.saveData();
                                        DataClass.formatTempData();
                                        new AlertDialog.Builder(ins)
                                                .setTitle("完了")
                                                .setMessage("保存しました。")
                                                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                                                    @Override
                                                    public void onClick(DialogInterface dialog, int which) {
                                                        Intent intent = new Intent(ins, MainActivity.class);
                                                        startActivity(intent);
                                                    }
                                                })
                                                .show();
                                    }
                                })
                                .setNegativeButton("いいえ", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {
                                        new AlertDialog.Builder(ins)
                                                .setTitle("注意")
                                                .setMessage("今回のデータは保存されません。" + "\n" + "よろしいですか？")
                                                .setPositiveButton("はい", new DialogInterface.OnClickListener() {
                                                    @Override
                                                    public void onClick(DialogInterface dialog, int which) {
                                                        DataClass.formatTempData();
                                                        Intent intent = new Intent(ins, MainActivity.class);
                                                        startActivity(intent);
                                                    }
                                                })
                                                .setNegativeButton("いいえ", null)
                                                .show();
                                    }
                                })
                                .show();
                    }
                })
                .setNegativeButton("いいえ", null)
                .show();
    }

}
