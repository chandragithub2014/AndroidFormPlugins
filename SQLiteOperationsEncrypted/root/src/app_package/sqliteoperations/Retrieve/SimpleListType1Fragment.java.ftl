package ${packageName}.sqliteoperations.Retrieve;

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
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>

import ${packageName}.sqliteoperations.DBHelpers.DBHelper;
import ${packageName}.sqliteoperations.DBHelpers.DBManager;
import ${packageName}.sqliteoperations.Interfaces.ClickListener;
import ${packageName}.sqliteoperations.UpdateDelete.PrepopulatedSectionedRegistrationFragment;


/**
 * A simple {@link Fragment} subclass.
 * Use the {@link SimpleListType1Fragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class SimpleListType1Fragment extends Fragment implements View.OnClickListener,ClickListener {
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

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }
int mContainerId = -1;
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        simpleListType1View = inflater.inflate(R.layout.fragment_simple_list_type1, container, false);
        mContainerId = container.getId();
        initToolBar();
        initDB();
        initDBHelper();
   //     callDBQuery("profile");
        simpleType1RecyclerView = (RecyclerView) simpleListType1View.findViewById(R.id.simpletype1recyclerview);
        add_item = (FloatingActionButton) simpleListType1View.findViewById(R.id.add_item);
        add_item.setOnClickListener(this);
        //    initTooBar("Basic List");
        simpleListType1Adapter = new SimpleListType1Adapter(getActivity(),  callDBQuery("profile"),SimpleListType1Fragment.this/*getSimpleListData()*/);
        simpleType1RecyclerView.setAdapter(simpleListType1Adapter);
        simpleType1RecyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));

        RecyclerView.ItemDecoration itemDecoration =
                new DividerItemDecoration(getActivity(), LinearLayoutManager.VERTICAL);
        simpleType1RecyclerView.addItemDecoration(itemDecoration);
        simpleType1RecyclerView.setItemAnimator(new DefaultItemAnimator());
        return simpleListType1View;
    }

    DBHelper dbHelper;

    private void initDB() {
        DBManager manager = new DBManager(getActivity());
        manager.load();
    }
    private void initDBHelper() {
        dbHelper = new DBHelper();
    }

    private List<SimpleDTOType1> callDBQuery(String tableName){
        List<Map<String,Object>> queryMapList =  dbHelper.queryInfoInDecryptedFormat(tableName);
        List<SimpleDTOType1> dataList = new ArrayList<>();
        for(int i=0;i<queryMapList.size();i++) {
            Map<String,Object> rowMap =  queryMapList.get(i);
            SimpleDTOType1 temp = new SimpleDTOType1();
            temp.title = (String) rowMap.get("firstname");
            temp.rowId = (int) rowMap.get("_id");
            dataList.add(temp);
            for (Map.Entry<String, Object> entry : rowMap.entrySet()) {
                System.out.println(entry.getKey() + "/" + entry.getValue());

            }
        }
        return  dataList;
    }


    private void initToolBar() {
        Toolbar mToolBar = (Toolbar) getActivity().findViewById(R.id.app_toolbar);
        TextView toolBarTitle = (TextView) mToolBar.findViewById(R.id.title);
        toolBarTitle.setText("SimpleList");

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.add_item:
                if (simpleListType1Adapter != null) {
                    simpleListType1Adapter.add();
                }
                break;
        }
    }


    @Override
    public void onClick(String columnName, String columnVal) {
        launchFragment(columnName,columnVal);
    }

    private void launchFragment(String columnName, String columnVal) {
        Fragment prepopulatedFragment =  PrepopulatedSectionedRegistrationFragment.newInstance(columnName,columnVal);
        getActivity().getSupportFragmentManager().beginTransaction()
                .replace(mContainerId, prepopulatedFragment)
                .commit();
    }
}