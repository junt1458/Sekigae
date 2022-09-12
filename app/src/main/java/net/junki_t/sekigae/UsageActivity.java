package net.junki_t.sekigae;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebView;


public class UsageActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_usage);
        WebView webView = (WebView) findViewById(R.id.webView);
        webView.loadUrl("http://junki-t.net/SmartPhoneApps/SeatChange/usage.php");
    }

    public void back_usage(View v){
        this.finish();
    }
}
