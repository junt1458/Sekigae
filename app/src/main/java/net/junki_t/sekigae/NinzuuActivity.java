package net.junki_t.sekigae;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class NinzuuActivity extends AppCompatActivity {

    EditText man;
    EditText woman;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ninzuu);
        man = (EditText) findViewById(R.id.editText);
        woman = (EditText) findViewById(R.id.editText2);
    }

    public void next_Ninzuu(View v){
        if(man.getText().toString().equalsIgnoreCase("") || woman.getText().toString().equalsIgnoreCase("")){
            Toast.makeText(this, "人数を入力してください。", Toast.LENGTH_LONG).show();
            return;
        }
        int manc = 0;
        int womanc = 0;
        try {
            manc = Integer.parseInt(man.getText().toString());
            womanc = Integer.parseInt(woman.getText().toString());
        } catch (NumberFormatException ex){
            Toast.makeText(this, "文字列が不正です。", Toast.LENGTH_LONG).show();
            return;
        }
        if((manc + womanc) > DataClass.CountLimit){
            Toast.makeText(this, "人数の合計を48人以上にすることはできません。", Toast.LENGTH_LONG).show();
        } else if((manc + womanc) <= 0){
            Toast.makeText(this, "人数の合計を0人以下にすることはできません。", Toast.LENGTH_LONG).show();
        } else if(manc < 0 || womanc < 0){
            Toast.makeText(this, "人数の数が不正です。", Toast.LENGTH_LONG).show();
        } else {
            DataClass.man = manc;
            DataClass.woman = womanc;
            DataClass.maxcount = manc + womanc;
            Intent intent = new Intent(this, HaitiActivity.class);
            startActivity(intent);
        }
    }

    public void loadData(View v){
        DataClass.loadData();
        if((DataClass.man + DataClass.woman) > DataClass.CountLimit || (DataClass.man + DataClass.woman) <= 0){
            Toast.makeText(this, "読み込むデータがありませんでした。", Toast.LENGTH_LONG).show();
        } else {
            Intent intent = new Intent(this, HaitiActivity.class);
            startActivity(intent);
        }
    }
}
