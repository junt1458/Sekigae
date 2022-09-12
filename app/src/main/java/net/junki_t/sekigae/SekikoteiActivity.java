package net.junki_t.sekigae;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class SekikoteiActivity extends AppCompatActivity {

    public static FontFitTextView[] imgbtn = new FontFitTextView[DataClass.CountLimit];
    public static SekikoteiActivity instance;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sekikotei);

        instance = this;

        for(int i = 1; i < (DataClass.CountLimit + 1); i++){
            int id = getResources().getIdentifier("nameSetText" + (i + 96), "id", getPackageName());
            imgbtn[i - 1] = (FontFitTextView) findViewById(id);
        }

        for(int i = 0; i < DataClass.CountLimit; i++){
            if(DataClass.sekistatus[i]){
                if(DataClass.m_wstatus[i]){
                    imgbtn[i].setBackgroundResource(R.drawable.man);
                    if(DataClass.Seat_Data[i] != -1){
                        imgbtn[i].setText(DataClass.People_Data[DataClass.Seat_Data[i]].Name);
                    } else {
                        imgbtn[i].setText("");
                    }
                } else {
                    imgbtn[i].setBackgroundResource(R.drawable.woman);
                    if(DataClass.Seat_Data[i] != -1){
                        imgbtn[i].setText(DataClass.People_Data[DataClass.Seat_Data[i]].Name);
                    } else {
                        imgbtn[i].setText("");
                    }
                }
            } else {
                imgbtn[i].setBackgroundResource(R.drawable.nodesk);
            }
        }

    }

    public void setkotei(View v){
        String rsName = this.getResources().getResourceEntryName(v.getId());
        int index = Integer.parseInt(rsName.replaceAll("nameSetText", "")) - (96 + 1);
        Intent intent = new Intent(this, SelectActivity.class);
        intent.putExtra("id", index);
        startActivity(intent);
    }

    public void redraw(){
        for(int i = 0; i < DataClass.CountLimit; i++){
            if(DataClass.sekistatus[i]){
                if(DataClass.m_wstatus[i]){
                    imgbtn[i].setBackgroundResource(R.drawable.man);
                    if(DataClass.Seat_Data[i] != -1){
                        imgbtn[i].setText(DataClass.People_Data[DataClass.Seat_Data[i]].Name);
                    } else {
                        imgbtn[i].setText("");
                    }
                } else {
                    imgbtn[i].setBackgroundResource(R.drawable.woman);
                    if(DataClass.Seat_Data[i] != -1){
                        imgbtn[i].setText(DataClass.People_Data[DataClass.Seat_Data[i]].Name);
                    } else {
                        imgbtn[i].setText("");
                    }
                }
            } else {
                imgbtn[i].setBackgroundResource(R.drawable.nodesk);
            }
        }
    }
}
