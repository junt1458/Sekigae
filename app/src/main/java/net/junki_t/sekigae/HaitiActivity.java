package net.junki_t.sekigae;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

public class HaitiActivity extends AppCompatActivity {

    public static ImageButton[] imgbtn = new ImageButton[DataClass.CountLimit];
    TextView tv;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_haiti);

        tv = (TextView) findViewById(R.id.textView10);

        for(int i = 1; i < (DataClass.CountLimit + 1); i++){
            int id = getResources().getIdentifier("imageButton" + i, "id", getPackageName());
            imgbtn[i - 1] = (ImageButton) findViewById(id);
            imgbtn[i - 1].setImageResource(android.R.color.transparent);
        }

        if(DataClass.sekistatus == null) {
            DataClass.sekistatus = new boolean[DataClass.CountLimit];
            for (int i = 0; i < DataClass.CountLimit; i++) {
                if (i < DataClass.maxcount) {
                    DataClass.sekistatus[i] = true;
                    imgbtn[i].setBackgroundResource(R.drawable.desk);
                } else {
                    DataClass.sekistatus[i] = false;
                    imgbtn[i].setBackgroundResource(R.drawable.nodesk);
                }
            }
        } else {
            for (int i = 0; i < DataClass.CountLimit; i++){
                if(DataClass.sekistatus[i]){
                    imgbtn[i].setBackgroundResource(R.drawable.desk);
                } else {
                    imgbtn[i].setBackgroundResource(R.drawable.nodesk);
                }
            }
        }
        tv.setText(getCount(true) + "/" + DataClass.maxcount);
    }

    public void toggle_haiti(View v){
        String rsName = this.getResources().getResourceEntryName(v.getId());
        int index = Integer.parseInt(rsName.replaceAll("imageButton", "")) - 1;
        if(DataClass.sekistatus[index]){
            DataClass.sekistatus[index] = false;
            imgbtn[index].setBackgroundResource(R.drawable.nodesk);
        } else {
            DataClass.sekistatus[index] = true;
            imgbtn[index].setBackgroundResource(R.drawable.desk);
        }
        tv.setText(getCount(true) + "/" + DataClass.maxcount);
    }

    public int getCount(boolean isTrue){
        int c = 0;
        for(int i = 0; i < DataClass.CountLimit; i++){
            if(DataClass.sekistatus[i] == isTrue){
                c++;
            }
        }
        return c;
    }

    public void next_haiti(View v){
        if(getCount(true) == DataClass.maxcount){
            Intent intent = new Intent(this, ManWomanSetActivity.class);
            startActivity(intent);
        } else {
            Toast.makeText(this, "使用する席の数と人数があっていません。", Toast.LENGTH_LONG).show();
        }
    }

}
