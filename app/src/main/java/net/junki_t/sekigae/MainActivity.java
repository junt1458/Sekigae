package net.junki_t.sekigae;

import android.Manifest;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    public static MainActivity instance;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        instance = this;
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        TextView tv = (TextView) findViewById(R.id.verView);
        PackageInfo packageInfo = null;
        try {
            packageInfo = getPackageManager().getPackageInfo("net.junki_t.sekigae", PackageManager.GET_META_DATA);
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        String ver = "null";
        ver = packageInfo.versionName;
        tv.setText("Ver " + ver);
    }

    public void usage(View v){
        Intent intent = new Intent(this, UsageActivity.class);
        startActivity(intent);
    }

    public void info(View v){
        Intent intent = new Intent(this, InformationActivity.class);
        startActivity(intent);
    }

    public void start(View v){
        Intent intent = new Intent(this, NinzuuActivity.class);
        startActivity(intent);
    }

    public void format(View v){
        final MainActivity ins = this;
        new AlertDialog.Builder(this)
                .setTitle("確認")
                .setMessage("データを削除しますか？")
                .setPositiveButton("はい", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        new AlertDialog.Builder(ins)
                                .setTitle("注意")
                                .setMessage("データを削除すると元に戻すことはできません" + "\n" + "本当にいいですか？")
                                .setPositiveButton("はい", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialog, int which) {
                                        DataClass.formatData();
                                        new AlertDialog.Builder(ins)
                                                .setTitle("完了")
                                                .setMessage("削除しました。")
                                                .setPositiveButton("OK", null)
                                                .show();
                                    }
                                })
                                .setNegativeButton("いいえ", null)
                                .show();
                    }
                })
                .setNegativeButton("いいえ", null)
                .show();
    }
}
