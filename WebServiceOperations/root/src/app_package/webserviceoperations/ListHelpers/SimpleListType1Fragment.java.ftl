package ${packageName}.webserviceoperations.ListHelpers;


import android.content.Context;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.<#if appCompat>support.v4.</#if>app.Fragment;
import android.support.v7.widget.DefaultItemAnimator;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>
import ${packageName}.webserviceoperations.WebServiceHelpers.HeroDTO;
import ${packageName}.webserviceoperations.WebServiceHelpers.WebServiceHelper;
import ${packageName}.webserviceoperations.interfaces.ResponseListener;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link SimpleListType1Fragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class SimpleListType1Fragment extends Fragment implements View.OnClickListener,ResponseListener {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    View simpleListType1View = null;
    FloatingActionButton add_item;
    Toolbar mToolBar;
    Context activityContext;
    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;
    private RecyclerView simpleType1RecyclerView;
    private SimpleListType1Adapter simpleListType1Adapter;
    Button post,put,delete;

    public SimpleListType1Fragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment SimpleListType1.
     */
    // TODO: Rename and change types and number of parameters
    public static SimpleListType1Fragment newInstance(String param1, String param2) {
        SimpleListType1Fragment fragment = new SimpleListType1Fragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }
    ArrayList<HeroDTO> heroDTOArrayList = null;
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
            heroDTOArrayList  = getArguments().getParcelableArrayList("heroArray");
        }

    }

    /*@Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

    }*/

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        simpleListType1View = inflater.inflate(R.layout.fragment_simple_list_type1_web_service, container, false);
        initToolBar();
        simpleType1RecyclerView = (RecyclerView) simpleListType1View.findViewById(R.id.simpletype1recyclerview);
        post = (Button)simpleListType1View.findViewById(R.id.post_data);
        put =  (Button)simpleListType1View.findViewById(R.id.put_data);
        delete =  (Button)simpleListType1View.findViewById(R.id.del_data);
        add_item = (FloatingActionButton) simpleListType1View.findViewById(R.id.add_item);
        add_item.setOnClickListener(this);
        post.setOnClickListener(this);
        put.setOnClickListener(this);
        delete.setOnClickListener(this);
        //    initTooBar("Basic List");
        simpleListType1Adapter = new SimpleListType1Adapter(getActivity(), getSimpleListData());
        simpleType1RecyclerView.setAdapter(simpleListType1Adapter);
        simpleType1RecyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));

        RecyclerView.ItemDecoration itemDecoration =
                new DividerItemDecoration(getActivity(), LinearLayoutManager.VERTICAL);
        simpleType1RecyclerView.addItemDecoration(itemDecoration);
        simpleType1RecyclerView.setItemAnimator(new DefaultItemAnimator());
        return simpleListType1View;
    }


    public List<HeroDTO> getSimpleListData() {
        List<HeroDTO> dataList = heroDTOArrayList;
        return dataList;
    }

    private void initToolBar() {
        Toolbar mToolBar = (Toolbar) getActivity().findViewById(R.id.app_toolbar);
        TextView toolBarTitle = (TextView) mToolBar.findViewById(R.id.title);
        toolBarTitle.setText("SimpleList");

    }

    @Override
    public void onClick(View v) {
       if(v == post){
           WebServiceHelper webServiceHelper =   WebServiceHelper.getInstance();
           webServiceHelper.init(getActivity(),SimpleListType1Fragment.this);
           webServiceHelper.postDataToWebService();
       }else if(v == put){
           WebServiceHelper webServiceHelper =   WebServiceHelper.getInstance();
           webServiceHelper.init(getActivity(),SimpleListType1Fragment.this);
           webServiceHelper.putDataToWebService();
       }else if(v==delete){
           WebServiceHelper webServiceHelper =   WebServiceHelper.getInstance();
           webServiceHelper.init(getActivity(),SimpleListType1Fragment.this);
           webServiceHelper.deleteDataFromWebService();
       }
    }

    @Override
    public void receiveResponse(String response) {

    }
}
