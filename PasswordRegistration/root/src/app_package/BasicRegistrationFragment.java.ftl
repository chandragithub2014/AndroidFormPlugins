package ${packageName};



import android.app.DatePickerDialog;
import android.content.ContentValues;
import android.os.Bundle;
import android.<#if appCompat>support.v4.</#if>app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

<#if applicationPackage??>
import ${applicationPackage}.R;
</#if>

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link BasicRegistrationFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class BasicRegistrationFragment extends Fragment implements View.OnClickListener,AdapterView.OnItemSelectedListener{
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;
    View basicRegistrationView = null;
    Button date_input;
    private int mYear, mMonth, mDay, mHour, mMinute;
    EditText firstName,secondName,addr1,addr2,comments;
    Spinner country,state;
    RadioGroup sex_radio_group;
    CheckBox chkb1,chkb2,chkb3;
    Button save,cancel;
    private RadioButton radioSexButton;
    List<String> checkedList;
    DBHelper dbHelper;

    public BasicRegistrationFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment BasicRegistrationFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static BasicRegistrationFragment newInstance(String param1, String param2) {
        BasicRegistrationFragment fragment = new BasicRegistrationFragment();
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

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        basicRegistrationView =  inflater.inflate(R.layout.registrationform, container, false);
        initDB();
        initDBHelper();
        initViews(basicRegistrationView);
        populateCountrySpinner();
        registerListeners();
        return  basicRegistrationView;
    }

    private void initViews(View v){

        date_input = (Button)v.findViewById(R.id.date_input);
        firstName = (EditText)v.findViewById(R.id.firstname_input);
        secondName = (EditText)v.findViewById(R.id.secondname_input);
        addr1 = (EditText)v.findViewById(R.id.address1);
        addr2 = (EditText)v.findViewById(R.id.address2);
        comments = (EditText)v.findViewById(R.id.comments_input);
        country = (Spinner)v.findViewById(R.id.spinner_country);
        state = (Spinner)v.findViewById(R.id.spinner_state);
        save = (Button)v.findViewById(R.id.save_form);
        cancel = (Button)v.findViewById(R.id.cancel_form);
        sex_radio_group = (RadioGroup) v.findViewById(R.id.radioSex);
        chkb1 = (CheckBox)v.findViewById(R.id.chk_1);
        chkb2 = (CheckBox)v.findViewById(R.id.chk_2);
        chkb3 = (CheckBox)v.findViewById(R.id.chk_3);
        checkedList = new ArrayList<>();

    }

    public void registerListeners(){
        date_input.setOnClickListener(this);
        save.setOnClickListener(this);
        cancel.setOnClickListener(this);
        chkb1.setOnClickListener(this);
        chkb2.setOnClickListener(this);
        chkb3.setOnClickListener(this);
        country.setOnItemSelectedListener(this);
        state.setOnItemSelectedListener(this);
    }


    @Override
    public void onClick(View view) {
        if(view == date_input){
            initCalendar();

            DatePickerDialog datePickerDialog = new DatePickerDialog(getActivity(),
                    new DatePickerDialog.OnDateSetListener() {

                        @Override
                        public void onDateSet(DatePicker view, int year,
                                              int monthOfYear, int dayOfMonth) {

                            date_input.setText(dayOfMonth + "-" + (monthOfYear + 1) + "-" + year);

                        }
                    }, mYear, mMonth, mDay);
            datePickerDialog.show();
        }else if(view == save){
            saveForm();
        }else if(view == chkb1){
             if(chkb1.isChecked()){
                 checkedList.add(chkb1.getText().toString());
             }
        }else if(view == chkb2){
            if(chkb2.isChecked()){
                checkedList.add(chkb2.getText().toString());
            }
        }else if(view == chkb3){
            if(chkb3.isChecked()){
                checkedList.add(chkb3.getText().toString());
            }
        }else if(view == cancel){
            clearData();
        }
    }
    private void initDB(){
        DBManager manager = new DBManager(getActivity());
        manager.load();
    }

    private  void initDBHelper(){
        dbHelper  = new DBHelper();
    }

    private  void initCalendar(){
        // Get Current Date
        final Calendar c = Calendar.getInstance();
        mYear = c.get(Calendar.YEAR);
        mMonth = c.get(Calendar.MONTH);
        mDay = c.get(Calendar.DAY_OF_MONTH);

    }
    /*
     firstname     TEXT        1                            0
2        lastname      TEXT        1                            0
3        address1      TEXT        1                            0
4        address2      TEXT        1                            0
5        dob           TEXT        1                            0
6        sex           TEXT        1                            0
7        sport         TEXT        1                            0
8        country       TEXT        1                            0
9        state         TEXT        1                            0
10       comments
     */

    private void saveForm(){
        String checkedVals = "";
        ContentValues cv = new ContentValues();
        // get selected radio button from radioGroup
        cv.put("sex",fetchSelectedRadioItems());
        if(checkedList!=null && checkedList.size()>0){

            for(int i=0;i<checkedList.size();i++){
                checkedVals+=checkedList.get(i)+",";
            }
        }else{
            if(chkb1.isChecked()){
                checkedList.add(chkb1.getText().toString());
            }
            if(chkb2.isChecked()){
                checkedList.add(chkb2.getText().toString());
            }

            if(chkb3.isChecked()){
                checkedList.add(chkb3.getText().toString());
            }
            if(checkedList!=null && checkedList.size()>0) {

                for (int i = 0; i < checkedList.size(); i++) {
                    checkedVals += checkedList.get(i) + ",";
                }
            }
        }
        cv.put("sport",checkedVals);
        checkedList = new ArrayList<>();
        cv.put("country",selectedCountry);
        cv.put("state",selectedState);
        cv.put("firstname",firstName.getText().toString());
        cv.put("lastname",secondName.getText().toString());
        cv.put("address1",addr1.getText().toString());
        cv.put("address2",addr2.getText().toString());
        cv.put("dob",date_input.getText().toString());
        cv.put("comments",comments.getText().toString());

        int id = dbHelper.insertData(cv,"profile");
        if(id!=-1){
            Toast.makeText(getActivity(),"Save Success...",Toast.LENGTH_LONG).show();
        }


    }

private String fetchSelectedRadioItems(){
        String selecteItem  = "";
    int selectedId = sex_radio_group.getCheckedRadioButtonId();

    // find the radiobutton by returned id
    radioSexButton = (RadioButton)basicRegistrationView.findViewById(selectedId);
    return  radioSexButton.getText().toString();
}
    private void populateCountrySpinner(){
        String[]  countryArray = getResources().getStringArray(R.array.country_arrays);
        country.setAdapter(new ArrayAdapter<String>(getActivity(),R.layout.spinner_row,countryArray));
    }

    String selectedCountry = "";
    String selectedState = "";
    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int i, long l) {
        Spinner spinner = (Spinner) parent;
        if(spinner.getId() == R.id.spinner_country)
        {
            String sqlQuery="";
            selectedCountry=country.getSelectedItem().toString();
            String columnName = "country";
            sqlQuery = columnName
                    + " = "
                    + "'"
                    + selectedCountry+ "'";
           List<String> stateList =  dbHelper.fetchStateList(sqlQuery);
           if(stateList.size()>0) {
               populateStateSpinner(stateList);
           }
        }
        else if(spinner.getId() == R.id.spinner_state)
        {
            selectedState = state.getSelectedItem().toString();
        }
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {

    }

    private void populateStateSpinner(List<String> stateList){
        String[]  stateArray = new String[stateList.size()];
        for(int i=0;i<stateList.size();i++){
            stateArray[i] = stateList.get(i);
        }
        if(stateArray.length>0) {
            state.setAdapter(new ArrayAdapter<String>(getActivity(), R.layout.spinner_row_2, stateArray));
        }
    }

/*
date_input = (Button)v.findViewById(R.id.date_input);
        firstName = (EditText)v.findViewById(R.id.firstname_input);
        secondName = (EditText)v.findViewById(R.id.secondname_input);
        addr1 = (EditText)v.findViewById(R.id.address1);
        addr2 = (EditText)v.findViewById(R.id.address2);
        comments = (EditText)v.findViewById(R.id.comments_input);
        country = (Spinner)v.findViewById(R.id.spinner_country);
        state = (Spinner)v.findViewById(R.id.spinner_state);
        save = (Button)v.findViewById(R.id.save_form);
        cancel = (Button)v.findViewById(R.id.cancel_form);
        sex_radio_group = (RadioGroup) v.findViewById(R.id.radioSex);
        chkb1 = (CheckBox)v.findViewById(R.id.chk_1);
        chkb2 = (CheckBox)v.findViewById(R.id.chk_2);
        chkb3 = (CheckBox)v.findViewById(R.id.chk_3);
        checkedList = new ArrayList<>();
 */
    private void clearData(){
        firstName.setText("");
        secondName.setText("");
        addr1.setText("");
        addr2.setText("");
        comments.setText("");
        country.setSelection(0);
        state.setSelection(0);
        chkb1.setSelected(false);
        chkb2.setSelected(false);
        chkb3.setSelected(false);

    }
}
