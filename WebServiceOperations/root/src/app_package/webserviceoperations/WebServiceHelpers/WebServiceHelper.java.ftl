package ${packageName}.webserviceoperations.WebServiceHelpers;

import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import ${packageName}.webserviceoperations.interfaces.ResponseListener;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by CHANDRASAIMOHAN on 12/1/2017.
 */

public class WebServiceHelper implements Response.Listener,
        Response.ErrorListener{
    private String TAG = getClass().getSimpleName();
    public static final String REQUEST_TAG = "MainActivity";
    Context ctx;
    ResponseListener responseListener;
    private RequestQueue mQueue;

    private static WebServiceHelper instance;

    private WebServiceHelper(){}

    public static WebServiceHelper getInstance(){
        if(instance == null){
            instance = new WebServiceHelper();
        }
        return instance;
    }

    public void init(Context ctx, ResponseListener responseListener){
        this.ctx = ctx;
        this.responseListener = responseListener;
    }
    public void fetchDataFromWebservice(String url){
        mQueue = CustomVolleyRequestQueue.getInstance(ctx)
                .getRequestQueue();
        //String url = "https://simplifiedcoding.net/demos/view-flipper/heroes.php";
        final CustomJSONObjectRequest jsonRequest = new CustomJSONObjectRequest(Request.Method
                .GET, url,
                new JSONObject(), this, this);
        jsonRequest.setTag(REQUEST_TAG);
        mQueue.add(jsonRequest);

    }
    private void stopQueue(){
        if (mQueue != null) {
            mQueue.cancelAll(REQUEST_TAG);
        }
    }
    @Override
    public void onResponse(Object response) {
        Log.d(TAG,"Response is:::"+response);
        stopQueue();
        responseListener.receiveResponse(response.toString());
     //   parseResponse(response.toString());
    }

    @Override
    public void onErrorResponse(VolleyError error) {

       // progressDialog.dismiss();
        stopQueue();
        responseListener.receiveResponse("FailedResponse");
        Log.d(TAG,"Error:::"+error.getMessage());
    }


    public void postDataToWebService(){
        String url = "http://httpbin.org/post";
        StringRequest postRequest = new StringRequest(Request.Method.POST, url,
                new Response.Listener<String>()
                {
                    @Override
                    public void onResponse(String response) {
                        // response
                        Log.d("Response", response);
                        Toast.makeText(ctx, "Post Successs", Toast.LENGTH_LONG).show();
                    }
                },
                new Response.ErrorListener()
                {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        // error
                        Log.d("Error.Response", error.getMessage());
                    }
                }
        ) {
            @Override
            protected Map<String, String> getParams()
            {
                Map<String, String>  params = new HashMap<String, String>();
                params.put("name", "Alif");
                params.put("domain", "http://itsalif.info");

                return params;
            }
        };
        mQueue.add(postRequest);
    }

    public void putDataToWebService(){
        String url = "http://httpbin.org/put";
        StringRequest putRequest = new StringRequest(Request.Method.PUT, url,
                new Response.Listener<String>()
                {
                    @Override
                    public void onResponse(String response) {
                        // response
                        Log.d("Response", response);
                        Toast.makeText(ctx, "Put Successs", Toast.LENGTH_LONG).show();
                    }
                },
                new Response.ErrorListener()
                {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        // error
                        Log.d("Error.Response", error.getMessage());
                    }
                }
        ) {

            @Override
            protected Map<String, String> getParams()
            {
                Map<String, String>  params = new HashMap<String, String> ();
                params.put("name", "Alif");
                params.put("domain", "http://itsalif.info");

                return params;
            }

        };

        mQueue.add(putRequest);
    }

    public void deleteDataFromWebService(){
        String url = "http://httpbin.org/delete";
        StringRequest dr = new StringRequest(Request.Method.DELETE, url,
                new Response.Listener<String>()
                {
                    @Override
                    public void onResponse(String response) {
                        // response
                        Toast.makeText(ctx, "Delete Successs", Toast.LENGTH_LONG).show();
                    }
                },
                new Response.ErrorListener()
                {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        // error.

                    }
                }
        );
        mQueue.add(dr);
    }

}
