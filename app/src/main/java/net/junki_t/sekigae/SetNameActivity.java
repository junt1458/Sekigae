package net.junki_t.sekigae;

import android.content.Context;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

public class SetNameActivity extends AppCompatActivity {

    ListView listView;
    EditText nameText;
    TextView genderText;
    TextView numberText;
    ArrayAdapter<String> adapter;
    int arrayindex = -1;
    private InputMethodManager inputMethodManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_set_name);
        listView = (ListView) findViewById(R.id.nameList);
        nameText = (EditText) findViewById(R.id.NameText);
        numberText = (TextView) findViewById(R.id.number_tv);
        genderText = (TextView) findViewById(R.id.gender_tv);

        adapter = new ArrayAdapter(this, android.R.layout.simple_expandable_list_item_1);

        listView.setAdapter(adapter);

        for (PeopleInformation pi : DataClass.People_Data) {
            String name = pi.Name;
            String seibetu = "女";
            if (pi.isMan) {
                seibetu = "男";
            }
            String no = "No." + pi.Number;
            adapter.add(no + "," + name + "," + seibetu);
        }

        inputMethodManager =  (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);

        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                ArrayAdapter adapter = (ArrayAdapter) listView.getAdapter();
                arrayindex = position;
                PeopleInformation pi = DataClass.People_Data[position];
                nameText.setText(pi.Name);
                numberText.setText(pi.Number + "番");
                String seibetu = "女";
                if (pi.isMan) {
                    seibetu = "男";
                }
                genderText.setText(seibetu);
            }
        });

        nameText.setOnKeyListener(new View.OnKeyListener() {

            //コールバックとしてonKey()メソッドを定義
            @Override
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                //イベントを取得するタイミングには、ボタンが押されてなおかつエンターキーだったときを指定
                if ((event.getAction() == KeyEvent.ACTION_DOWN) && (keyCode == KeyEvent.KEYCODE_ENTER)) {
                    //キーボードを閉じる
                    inputMethodManager.hideSoftInputFromWindow(nameText.getWindowToken(), InputMethodManager.RESULT_UNCHANGED_SHOWN);
                    hanei();
                    return true;
                }

                return false;
            }
        });
    }

    public void hannei(View v) {
        hanei();
    }

    public void hanei() {
        if (arrayindex != -1) {
            String name = nameText.getText().toString();
            DataClass.People_Data[arrayindex].Name = name;
            Toast.makeText(this, "変更しました。", Toast.LENGTH_LONG).show();
        } else {
            Toast.makeText(this, "アイテムが選択されていません。", Toast.LENGTH_LONG).show();
        }

        arrayindex++;
        if(arrayindex >= DataClass.People_Data.length){
            arrayindex = 0;
        }

        PeopleInformation pii = DataClass.People_Data[arrayindex];
        nameText.setText(pii.Name);
        numberText.setText(pii.Number + "番");
        String seibetuu = "女";
        if (pii.isMan) {
            seibetuu = "男";
        }
        genderText.setText(seibetuu);



        adapter = new ArrayAdapter(this, android.R.layout.simple_expandable_list_item_1);

        listView.setAdapter(adapter);

        for (PeopleInformation pi : DataClass.People_Data) {
            String name = pi.Name;
            String seibetu = "女";
            if (pi.isMan) {
                seibetu = "男";
            }
            String no = "No." + pi.Number;
            adapter.add(no + "," + name + "," + seibetu);
        }

    }

}
