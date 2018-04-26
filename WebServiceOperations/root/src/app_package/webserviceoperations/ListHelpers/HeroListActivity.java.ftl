package ${packageName}.webserviceoperations.ListHelpers;

import android.app.ProgressDialog;
import android.<#if appCompat>support.v4.</#if>app.Fragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.android.volley.RequestQueue;
<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>


import ${packageName}.webserviceoperations.WebServiceHelpers.HeroDTO;
import ${packageName}.webserviceoperations.WebServiceHelpers.WebServiceHelper;
import ${packageName}.webserviceoperations.interfaces.ResponseListener;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class HeroListActivity extends AppCompatActivity implements /*Response.Listener,
        Response.ErrorListener*/ ResponseListener{
    private Toolbar mToolbar;
    private String TAG = getClass().getSimpleName();

    public static final String REQUEST_TAG = "MainActivity";
    private RequestQueue mQueue;
    ProgressDialog progressDialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hero_list);
        mToolbar = (Toolbar) findViewById(R.id.app_toolbar);
        setSupportActionBar(mToolbar);
        LayoutInflater mInflater = LayoutInflater.from(getApplicationContext());
        View mCustomView = mInflater.inflate(R.layout.toolbar_custom_view, null);
        mToolbar.addView(mCustomView);

    }

    private void launchFragment(ArrayList<HeroDTO> heroDTOList) {
        Bundle bundle = new Bundle();
        bundle.putParcelableArrayList("heroArray", heroDTOList);
        Fragment simpleListFrag = new SimpleListType1Fragment();
        simpleListFrag.setArguments(bundle);
        getSupportFragmentManager().beginTransaction()
                .replace(R.id.frag_parentLayout, simpleListFrag)
                .commit();
    }


    @Override
    protected void onStart() {
        super.onStart();
        // Instantiate the RequestQueue.
        progressDialog = new ProgressDialog(this);
        progressDialog.setTitle("Loading...");
        progressDialog.show();

      /*  mQueue = CustomVolleyRequestQueue.getInstance(this.getApplicationContext())
                .getRequestQueue();
        String url = "https://simplifiedcoding.net/demos/view-flipper/heroes.php";
        final CustomJSONObjectRequest jsonRequest = new CustomJSONObjectRequest(Request.Method
                .GET, url,
                new JSONObject(), this, this);
        jsonRequest.setTag(REQUEST_TAG);
        mQueue.add(jsonRequest);*/
    WebServiceHelper webServiceHelper =   WebServiceHelper.getInstance();
    webServiceHelper.init(getApplicationContext(),HeroListActivity.this);
    webServiceHelper.fetchDataFromWebservice("https://simplifiedcoding.net/demos/view-flipper/heroes.php");
      //new WebServiceHelper(getApplicationContext(),HeroListActivity.this).fetchDataFromWebservice("https://simplifiedcoding.net/demos/view-flipper/heroes.php");


    }

    @Override
    protected void onStop() {
        super.onStop();
        if (mQueue != null) {
            mQueue.cancelAll(REQUEST_TAG);
        }
    }
  /*  @Override
    public void onResponse(Object response) {
        Log.d(TAG,"Response is:::"+response);
        parseResponse(response.toString());
    }

    @Override
    public void onErrorResponse(VolleyError error) {

        progressDialog.dismiss();Log.d(TAG,"Error:::"+error.getMessage());
    }*/

    private void parseResponse(String response){
        ArrayList<HeroDTO> heroDTOList = new ArrayList<>();
        try {
            JSONObject jsonObject = new JSONObject(response);
            JSONArray jsonArray = jsonObject.getJSONArray("heroes");
            if(jsonArray!=null && jsonArray.length()>0){

                for(int i=0;i<jsonArray.length();i++){
                    JSONObject jsonChild = jsonArray.getJSONObject(i);
                    HeroDTO heroDTO = new HeroDTO();
                    heroDTO.setName(jsonChild.getString("name"));
                    heroDTO.setImageURL(jsonChild.getString("imageurl"));
                    heroDTOList.add(heroDTO);

                }
            }
        }catch (JSONException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
        if(heroDTOList!=null && heroDTOList.size()>0){
            progressDialog.dismiss();
            launchFragment(heroDTOList);
        }else {
            progressDialog.dismiss();
        }
    }

    @Override
    public void receiveResponse(String response) {
        if(progressDialog!=null && progressDialog.isShowing()) {
            progressDialog.dismiss();
        }
        if(!response.equalsIgnoreCase("failedResponse")) {
            parseResponse(response);
        }else{
            Toast.makeText(getApplicationContext(),"Webservice Failed Error",Toast.LENGTH_LONG).show();
        }
    }
}
