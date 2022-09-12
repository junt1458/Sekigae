package net.junki_t.sekigae;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import java.util.ArrayList;
import java.util.List;

public class SelectActivity extends AppCompatActivity {

    ArrayAdapter<String> adapter;
    List<PeopleInformation> list;
    ListView listView;
    int seki;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_select);
        listView = (ListView) findViewById(R.id.listView);
        list = new ArrayList<>();

        adapter = new ArrayAdapter(this, android.R.layout.simple_expandable_list_item_1);

        listView.setAdapter(adapter);
        seki = getIntent().getIntExtra("id", -1);

        for (PeopleInformation pi : DataClass.People_Data) {
            if(DataClass.m_wstatus[seki] == pi.isMan) {
                String name = pi.Name;
                String no = "No." + pi.Number;
                list.add(pi);
                adapter.add(no + "," + name);
            }
        }



        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                if(DataClass.Seat_Data[seki] != -1){
                    DataClass.People_Data[DataClass.Seat_Data[seki]].SeatNumber = -1;
                }
                if(DataClass.People_Data[list.get(position).AllNumber].SeatNumber != -1){
                    DataClass.Seat_Data[DataClass.People_Data[list.get(position).AllNumber].SeatNumber] = -1;
                }
                DataClass.Seat_Data[seki] = list.get(position).AllNumber;
                DataClass.People_Data[DataClass.Seat_Data[seki]].SeatNumber = seki;
                SekikoteiActivity.instance.redraw();
                finish();
            }
        });
    }

    public void unset(View v){
        if(DataClass.Seat_Data[seki] != -1){
            DataClass.People_Data[DataClass.Seat_Data[seki]].SeatNumber = -1;
        }
        DataClass.Seat_Data[seki] = -1;
        SekikoteiActivity.instance.redraw();
        finish();
    }
}
