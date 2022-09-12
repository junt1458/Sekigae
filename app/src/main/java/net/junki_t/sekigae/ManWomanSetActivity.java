package net.junki_t.sekigae;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

public class ManWomanSetActivity extends AppCompatActivity {

    public static ImageButton[] imgbtn = new ImageButton[DataClass.CountLimit];
    TextView manView;
    TextView womanView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_man_woman_set);
        manView = (TextView) findViewById(R.id.textView11);
        womanView = (TextView) findViewById(R.id.textView12);
        for(int i = 1; i < (DataClass.CountLimit + 1); i++){
            int id = this.getResources().getIdentifier("imageButton" + (i + 48), "id", this.getPackageName());
            imgbtn[i - 1] = (ImageButton) findViewById(id);
            imgbtn[i - 1].setImageResource(android.R.color.transparent);
        }
        for (int i = 0; i < DataClass.CountLimit; i++){
            if(DataClass.sekistatus[i]){
                imgbtn[i].setBackgroundResource(R.drawable.desk);
            } else {
                imgbtn[i].setBackgroundResource(R.drawable.nodesk);
                imgbtn[i].setEnabled(false);
            }
        }
        if(DataClass.m_wstatus == null) {
            DataClass.m_wstatus = new boolean[DataClass.CountLimit];
            int man = 0;
            for (int i = 0; i < DataClass.CountLimit; i++) {
                if(DataClass.sekistatus[i]){
                    if(man < DataClass.man){
                        man++;
                        DataClass.m_wstatus[i] = true;
                        imgbtn[i].setBackgroundResource(R.drawable.man);
                    } else {
                        DataClass.m_wstatus[i] = false;
                        imgbtn[i].setBackgroundResource(R.drawable.woman);
                    }
                } else {
                    DataClass.m_wstatus[i] = true;
                    imgbtn[i].setBackgroundResource(R.drawable.nodesk);
                }
            }
        } else {
            for(int i = 0; i < DataClass.CountLimit; i++){
                if(DataClass.sekistatus[i]) {
                    if(DataClass.m_wstatus[i]){
                        imgbtn[i].setBackgroundResource(R.drawable.man);
                    } else {
                        imgbtn[i].setBackgroundResource(R.drawable.woman);
                    }
                } else {
                    imgbtn[i].setBackgroundResource(R.drawable.nodesk);
                }
            }
        }
        manView.setText(getCount(true) + "/" + DataClass.man);
        womanView.setText(getCount(false) + "/" + DataClass.woman);
    }

    public void toggle_ManWoman(View v){
        String rsName = this.getResources().getResourceEntryName(v.getId());
        int index = Integer.parseInt(rsName.replaceAll("imageButton", "")) - 1 - 48;
        if(DataClass.m_wstatus[index]){
            DataClass.m_wstatus[index] = false;
            imgbtn[index].setBackgroundResource(R.drawable.woman);
        } else {
            DataClass.m_wstatus[index] = true;
            imgbtn[index].setBackgroundResource(R.drawable.man);
        }
        manView.setText(getCount(true) + "/" + DataClass.man);
        womanView.setText(getCount(false) + "/" + DataClass.woman);
    }

    public void next_manwoman(View v){
        if(getCount(true) == DataClass.man && getCount(false) == DataClass.woman){
            Intent intent = new Intent(this, CheckActivity.class);
            startActivity(intent);
        } else {
            Toast.makeText(this, "男子と女子の配置の人数があっていません。", Toast.LENGTH_LONG).show();
        }
    }

    public static int getCount(boolean isMan){
        int c = 0;
        for(int i = 0; i < DataClass.CountLimit; i++){
            if(DataClass.sekistatus[i] && isMan == DataClass.m_wstatus[i]){
                c++;
            }
        }
        return c;
    }
}
