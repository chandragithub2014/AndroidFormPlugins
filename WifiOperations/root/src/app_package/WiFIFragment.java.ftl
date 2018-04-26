package ${packageName};




import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.wifi.ScanResult;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.<#if appCompat>support.v4.</#if>app.Fragment;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>


import java.util.List;


/**
 * A simple {@link Fragment} subclass.
 * Use the {@link WiFIFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class WiFIFragment extends Fragment implements View.OnClickListener{
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;
    View wifiView = null;
    private int mContainerId = -1;
    TextView mainText;
    Button enable_wifi,open_wifi_settings,disable_wifi;
    WifiManager mainWifi;
  //  WifiReceiver receiverWifi;
    List<ScanResult> wifiList;
    StringBuilder sb = new StringBuilder();
    Context ctx;

    public WiFIFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment WiFIFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static WiFIFragment newInstance(String param1, String param2) {
        WiFIFragment fragment = new WiFIFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
        initWifiManager();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        wifiView =  inflater.inflate(R.layout.fragment_wi_fi, container, false);
        initToolBar();
        mContainerId = container.getId();
        initViews(wifiView);
        registerForClickListeners();


        return wifiView;
    }

   /* @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_item_1:
                // Not implemented here
                mainWifi.startScan();
                mainText.setText("Starting Scan");
                return true;
          
            default:
                break;
        }

        return false;

    }*/

    private void initViews(View view){
        mainText = (TextView)view.findViewById(R.id.mainText);
        enable_wifi = (Button)view.findViewById(R.id.btn_enable_wifi);
        open_wifi_settings = (Button)view.findViewById(R.id.btn_enable_wifi_settings);
        disable_wifi = (Button)view.findViewById(R.id.btn_disable_wifi);
    }

    private void registerForClickListeners(){
        enable_wifi.setOnClickListener(this);
        disable_wifi.setOnClickListener(this);
        open_wifi_settings.setOnClickListener(this);
    }
    private void initWifiManager(){
        // Initiate wifi service manager
        mainWifi = (WifiManager)getActivity().getApplicationContext().getSystemService(Context.WIFI_SERVICE);
    }
    private void launchToolBarChild() {
    }

    String tempTitle = "";
    private void initToolBar() {
        Toolbar mToolBar = (Toolbar) getActivity().findViewById(R.id.app_toolbar);
        TextView toolBarTitle = (TextView) mToolBar.findViewById(R.id.title);
        toolBarTitle.setText("Wifi Tester");
      //  Button toolBarButton = (Button) mToolBar.findViewById(R.id.btn_toolbar);



    }


    // Broadcast receiver class called its receive method
    // when number of wifi connections changed



    @Override
    public void onResume() {
        super.onResume();
    }


    @Override
    public void onPause() {
        super.onPause();
    }

    private void enableDisableWifi(){
        // Check for wifi is disabled
        if (mainWifi.isWifiEnabled() == false)
        {
            // If wifi disabled then enable it
            Toast.makeText(getActivity(), "wifi is disabled..making it enabled",
                    Toast.LENGTH_LONG).show();

            mainWifi.setWifiEnabled(true);
        }
        // wifi scaned value broadcast receiver
        // Register broadcast receiver
        // Broacast receiver will automatically call when number of wifi connections changed
        mainWifi.startScan();
      //  mainText.setText("Starting Scan...");
    }

    private void setOpen_wifi_settings(){
        final Intent intent = new Intent(Intent.ACTION_MAIN, null);
        intent.addCategory(Intent.CATEGORY_LAUNCHER);
        final ComponentName cn = new ComponentName("com.android.settings", "com.android.settings.wifi.WifiSettings");
        intent.setComponent(cn);
        intent.setFlags(intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
    }

    private void disableWifi(){
        if (mainWifi.isWifiEnabled() == true){
            Toast.makeText(getActivity(), "wifi is enabled..making it disabled",
                    Toast.LENGTH_LONG).show();

            mainWifi.setWifiEnabled(false);
        }
    }

    @Override
    public void onClick(View view) {
        if(view == open_wifi_settings){
            setOpen_wifi_settings();
        }else if(view == enable_wifi){
            enableDisableWifi();
        }else if(view == disable_wifi){
            disableWifi();
        }
    }
}
