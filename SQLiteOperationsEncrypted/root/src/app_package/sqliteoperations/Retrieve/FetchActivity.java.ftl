package ${packageName}.sqliteoperations.Retrieve;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.View;

<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>


public class FetchActivity extends AppCompatActivity {
    private Toolbar mToolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fetch);
        mToolbar = (Toolbar) findViewById(R.id.app_toolbar);
        setSupportActionBar(mToolbar);
        LayoutInflater mInflater = LayoutInflater.from(getApplicationContext());
        View mCustomView = mInflater.inflate(R.layout.toolbar_custom_view, null);
        mToolbar.addView(mCustomView);
        launchFragment();
    }

    private void launchFragment() {
        Fragment simpleListFrag = new SimpleListType1Fragment();
        getSupportFragmentManager().beginTransaction()
                .replace(R.id.frag_parentLayout, simpleListFrag)
                .commit();
    }
}
