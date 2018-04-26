package ${packageName};


import android.os.Bundle;
import android.app.Activity;
import android.<#if appCompat>support.v4.</#if>app.Fragment;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.View;
import android.view.ViewGroup;

<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>

//Note: Change package name for custom EditText Accordingly
public class YahooTypeLoginFragment extends Fragment {
	View loginView;

      @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
    		Bundle savedInstanceState) {
    	 super.onCreateView(inflater, container, savedInstanceState);
 		loginView = inflater.inflate(R.layout.yahoo_login_type_layout, container, false);
 		return loginView;
    }	

}
