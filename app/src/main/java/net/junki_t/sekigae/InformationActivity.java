package net.junki_t.sekigae;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class InformationActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_information);
        WebView webview = (WebView) findViewById(R.id.webView2);
        webview.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView webview, String url) {
                webview.loadUrl(url);
                return false;
            }
        });
        webview.loadUrl("http://junki-t.net/SmartPhoneApps/SeatChange/info.php");
    }

    public void back_info(View v){
        this.finish();
    }
}
