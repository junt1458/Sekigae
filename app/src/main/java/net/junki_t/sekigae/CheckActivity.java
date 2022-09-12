package net.junki_t.sekigae;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Switch;

public class CheckActivity extends AppCompatActivity {

    public static CheckActivity ca;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_check);
        ca = this;
        if(DataClass.People_Data != null){
            if(DataClass.People_Data.length != DataClass.maxcount){
                DataClass.People_Data = null;
            }
        }
        if(DataClass.People_Data == null) {
            DataClass.People_Data = new PeopleInformation[DataClass.maxcount];
            for(int i = 0; i < DataClass.maxcount; i++){
                if(i < DataClass.man){
                    DataClass.People_Data[i] = new PeopleInformation(true, -1, (i + 1) + "番", i + 1, i);
                } else {
                    int c = i - DataClass.man;
                    c++;
                    DataClass.People_Data[i] = new PeopleInformation(false, -1, c + "番", c, i);
                }
            }
        }
        if(DataClass.Seat_Data == null){
            DataClass.Seat_Data = new int[DataClass.CountLimit];
            for(int i = 0; i < DataClass.CountLimit; i++){
                DataClass.Seat_Data[i] = -1;
            }
        }
        Switch sw = (Switch) findViewById(R.id.switch2);
        sw.setChecked(DataClass.rotateLabel);
    }

    public void change_sw1(View v){
        Switch sw = (Switch) v;
        DataClass.colorLabel = sw.isChecked();
    }

    public void change_sw2(View v){
        Switch sw = (Switch) v;
        DataClass.rotateLabel = sw.isChecked();
    }

    public void rottery(View v){
        Intent intent = new Intent(this, ResultActivity.class);
        startActivity(intent);
    }

    public void setName(View v){
        Intent intent = new Intent(this, SetNameActivity.class);
        startActivity(intent);
    }

    public void sekikotei(View v){
        Intent intent = new Intent(this, SekikoteiActivity.class);
        startActivity(intent);
    }
}
