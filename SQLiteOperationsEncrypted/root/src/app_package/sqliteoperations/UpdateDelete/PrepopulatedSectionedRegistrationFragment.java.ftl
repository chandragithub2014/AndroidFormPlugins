package ${packageName}.sqliteoperations.UpdateDelete;

import android.app.DatePickerDialog;
import android.content.ContentValues;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

<#if applicationPackage??>
import ${applicationPackage}.R;
<#else>
import ${packageName}.R;
 </#if>

import ${packageName}.sqliteoperations.DBHelpers.DBHelper;
import ${packageName}.sqliteoperations.DBHelpers.DBManager;
import ${packageName}.sqliteoperations.Retrieve.FetchActivity;
import ${packageName}.sqliteoperations.AESHelpers.AESUtil;



/**
 * A simple {@link Fragment} subclass.
 * Use the {@link PrepopulatedSectionedRegistrationFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class PrepopulatedSectionedRegistrationFragment extends Fragment implements View.OnClickListener, AdapterView.OnItemSelectedListener {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    //Declarations
    Button date_input, save ,fetch;
    EditText firstName, secondName, addr1, addr2, comments,mobile1,mobile2,emailId,zipCode;
    Spinner country, state, sex, sport;
    View sectionedFormView = null;
    DBHelper dbHelper;
    String selectedSex = "";
    String selectedCountry = "";
    String selectedState = "";
    String selectedSport = "";
    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;
    private int mYear, mMonth, mDay, mHour, mMinute;

    //End
    public PrepopulatedSectionedRegistrationFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment SectionedRegistrationFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static PrepopulatedSectionedRegistrationFragment newInstance(String param1, String param2) {
        PrepopulatedSectionedRegistrationFragment fragment = new PrepopulatedSectionedRegistrationFragment();
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
        sectionedFormView = inflater.inflate(R.layout.fragment_profile_sqlite, container, false);
        initDB();
        initDBHelper();
      //  callDBQuery();
        initViews(sectionedFormView);
        registerListeners();
        populateCountrySpinner();
        populateSexSpinner();
        populateSportsSpinner();
        fetchSelectedRowData(mParam1,mParam2);
        return sectionedFormView;
    }

    private void initDB() {
        DBManager manager = new DBManager(getActivity());
        manager.load();
    }

    private void fetchSelectedRowData(String columnName, String columnValue){
        Map<String,Object> rowMap =      dbHelper.retrieveDecryptedRowDataBasedOnColumn("profile",columnName,columnValue);
        if(rowMap!=null && rowMap.size()>0){
            populateForm(rowMap);
        }
    }
    private void populateForm(Map<String,Object> rowData){
         firstName.setText((String)rowData.get("firstname"));
         secondName.setText((String)rowData.get("lastname"));
         date_input.setText((String)rowData.get("dob"));
         addr1.setText((String)rowData.get("address1"));
         addr2.setText((String)rowData.get("address2"));
         comments.setText((String)rowData.get("comments"));
         String selectedCountry  = (String)rowData.get("country");
         country.setSelection(countryAdapter.getPosition(selectedCountry));
        /* String selectedState  = (String)rowData.get("state");
         state.setSelection(stateAdapter.getPosition(selectedState));*/
         String selectedSex  = (String)rowData.get("sex");
         sex.setSelection(sexAdapter.getPosition(selectedSex));
        mobile1.setText((String)rowData.get("mobile"));
        mobile2.setText((String)rowData.get("mobile2"));
        emailId.setText((String)rowData.get("emailId"));
        zipCode.setText((String)rowData.get("zipcode"));
    }

/*    private void callDBQuery(){
     List<Map<String,Object>> queryMapList =  dbHelper.queryInfo("profile");
     for(int i=0;i<queryMapList.size();i++) {
         Map<String,Object> rowMap =  queryMapList.get(i);
         for (Map.Entry<String, Object> entry : rowMap.entrySet()) {
             System.out.println(entry.getKey() + "/" + entry.getValue());
         }
     }
    }*/
    private void initDBHelper() {
        dbHelper = new DBHelper();
    }

    private void initViews(View v) {

        date_input = (Button) v.findViewById(R.id.date_input);
        firstName = (EditText) v.findViewById(R.id.firstname_input);
        secondName = (EditText) v.findViewById(R.id.secondname_input);
        addr1 = (EditText) v.findViewById(R.id.address1);
        addr2 = (EditText) v.findViewById(R.id.address2);
        comments = (EditText) v.findViewById(R.id.comments_input);
        country = (Spinner) v.findViewById(R.id.spinner_country);
        state = (Spinner) v.findViewById(R.id.spinner_state);
        sex = (Spinner) v.findViewById(R.id.spinner_sex);
        sport = (Spinner) v.findViewById(R.id.spinner_sport);
        save = (Button) v.findViewById(R.id.save_form);
        fetch = (Button) v.findViewById(R.id.view_form);
        mobile1 = (EditText)v.findViewById(R.id.mobile1);
        mobile2 = (EditText)v.findViewById(R.id.mobile2);
        emailId = (EditText)v.findViewById(R.id.email);
        zipCode = (EditText)v.findViewById(R.id.zipcode);
        save.setText("Update");
        fetch.setText("Delete");
      /*  cancel = (Button)v.findViewById(R.id.cancel_form);
        sex_radio_group = (RadioGroup) v.findViewById(R.id.radioSex);
        chkb1 = (CheckBox)v.findViewById(R.id.chk_1);
        chkb2 = (CheckBox)v.findViewById(R.id.chk_2);
        chkb3 = (CheckBox)v.findViewById(R.id.chk_3);
        checkedList = new ArrayList<>();*/

    }

    public void registerListeners() {
        date_input.setOnClickListener(this);
        save.setOnClickListener(this);
        fetch.setOnClickListener(this);
        // chkb1.setOnClickListener(this);
        //   chkb2.setOnClickListener(this);
        //   chkb3.setOnClickListener(this);
        country.setOnItemSelectedListener(this);
        state.setOnItemSelectedListener(this);
    }

    @Override
    public void onClick(View view) {
        if (view == date_input) {
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
        } else if (view == save) {
            //saveForm();
            saveFormInEncryptedFormat();
        }else if(view == fetch){
            //launchList();
            launchAlertDialog();
        }
    }
    ArrayAdapter<CharSequence> countryAdapter = null;
    private void populateCountrySpinner() {
        String[] countryArray = getResources().getStringArray(R.array.country_arrays);
        //  country.setAdapter(new ArrayAdapter<String>(getActivity(),R.layout.spinner_row,countryArray));

        countryAdapter = ArrayAdapter.createFromResource(getActivity(),
                R.array.country_arrays, android.R.layout.simple_spinner_item);
// Specify the layout to use when the list of choices appears
        countryAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
// Apply the adapter to the spinner
        country.setAdapter(countryAdapter);
    }
    ArrayAdapter<String> sexAdapter = null;
    private void populateSexSpinner() {
        ArrayList<String> sexList = new ArrayList<>();
        selectedSex = "male";
        sexList.add("male");
        sexList.add("female");
        sexAdapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_single_choice, sexList);
        sex.setAdapter(sexAdapter);
        sex.setSelection(0);

    }

    private void populateSportsSpinner() {
        ArrayList<String> favouriteSportList = new ArrayList<>();
        favouriteSportList.add("cricket");
        favouriteSportList.add("football");
        favouriteSportList.add("tennis");
        favouriteSportList.add("volleyball");
        ArrayAdapter<String> sexAdapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_multiple_choice, favouriteSportList);
        sport.setAdapter(sexAdapter);
        sport.setSelection(0);
    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int i, long l) {
        Spinner spinner = (Spinner) parent;
        if (spinner.getId() == R.id.spinner_country) {
            String sqlQuery = "";
            selectedCountry = country.getSelectedItem().toString();
            String columnName = "country";
            sqlQuery = columnName
                    + " = "
                    + "'"
                    + selectedCountry + "'";
            List<String> stateList = dbHelper.fetchStateList(sqlQuery);
            if (stateList.size() > 0) {
                populateStateSpinner(stateList);
            }
        } else if (spinner.getId() == R.id.spinner_state) {
            selectedState = state.getSelectedItem().toString();
        } else if (spinner.getId() == R.id.spinner_sex) {
            selectedSex = sex.getSelectedItem().toString();
        } else if (spinner.getId() == R.id.spinner_sport) {
            selectedSport += sport.getSelectedItem().toString() + ",";
        }
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {

    }

    private void initCalendar() {
        // Get Current Date
        final Calendar c = Calendar.getInstance();
        mYear = c.get(Calendar.YEAR);
        mMonth = c.get(Calendar.MONTH);
        mDay = c.get(Calendar.DAY_OF_MONTH);

    }
    ArrayAdapter<String> stateAdapter = null;
    private void populateStateSpinner(List<String> stateList) {
        String[] stateArray = new String[stateList.size()];
        for (int i = 0; i < stateList.size(); i++) {
            stateArray[i] = stateList.get(i);
        }
        if (stateList.size() > 0) {
            //state.setAdapter(new ArrayAdapter<String>(getActivity(), R.layout.spinner_row_2, stateArray));
            stateAdapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_spinner_item, stateList);
            stateAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
            state.setAdapter(stateAdapter);
        }
    }

    private void saveForm() {
        //Log.d("Registration","CheckedItems:::"+selectedSport);
        ContentValues cv = new ContentValues();
        cv.put("sex", selectedSex);
        cv.put("sport", "");
        cv.put("country", selectedCountry);
        cv.put("state", selectedState);
        cv.put("firstname", firstName.getText().toString());
        cv.put("lastname", secondName.getText().toString());
        cv.put("address1", addr1.getText().toString());
        cv.put("address2", addr2.getText().toString());
        cv.put("dob", date_input.getText().toString());
        cv.put("comments", comments.getText().toString());
        cv.put("mobile",mobile1.getText().toString());
        cv.put("mobile2",mobile2.getText().toString());
        cv.put("emailId",emailId.getText().toString());
        cv.put("zipcode",zipCode.getText().toString());

        int id = dbHelper.updateEncryptedData("profile",cv,mParam1,mParam2);
        if (id != -1) {
            Toast.makeText(getActivity(), "Update Success...", Toast.LENGTH_LONG).show();
        }

    }


    private void saveFormInEncryptedFormat() {
        //Log.d("Registration","CheckedItems:::"+selectedSport);
        ContentValues cv = new ContentValues();
        cv.put("sex", AESUtil.getEncodedString(selectedSex));
        cv.put("sport", "");
        cv.put("country", AESUtil.getEncodedString(selectedCountry));
        cv.put("state", AESUtil.getEncodedString(selectedState));
        cv.put("firstname", AESUtil.getEncodedString(firstName.getText().toString()));
        cv.put("lastname", AESUtil.getEncodedString(secondName.getText().toString()));
        cv.put("address1", AESUtil.getEncodedString(addr1.getText().toString()));
        cv.put("address2", AESUtil.getEncodedString(addr2.getText().toString()));
        cv.put("dob", AESUtil.getEncodedString(date_input.getText().toString()));
        cv.put("comments", AESUtil.getEncodedString(comments.getText().toString()));
        cv.put("mobile",AESUtil.getEncodedString(mobile1.getText().toString()));
        cv.put("mobile2",AESUtil.getEncodedString(mobile2.getText().toString()));
        cv.put("emailId",AESUtil.getEncodedString(emailId.getText().toString()));
        cv.put("zipcode",AESUtil.getEncodedString(zipCode.getText().toString()));

        int id = dbHelper.updateEncryptedData("profile",cv,mParam1,mParam2);
        if (id != -1) {
            Toast.makeText(getActivity(), "Update Success...", Toast.LENGTH_LONG).show();
        }

    }

    private void launchList(){
        Intent listIntent  = new Intent(getActivity(), FetchActivity.class);
        startActivity(listIntent);
    }


    private void launchAlertDialog(){
        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
                getActivity());

        // set title
        alertDialogBuilder.setTitle("Profile Information");

        // set dialog message
        alertDialogBuilder
                .setMessage("Do you want to delete ?")
                .setCancelable(false)
                .setPositiveButton("Yes",new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        // if this button is clicked, close
                        // current activity
                       // MainActivity.this.finish();
                        int deletedId  =   dbHelper.deleteEncryptedData("profile",mParam1,mParam2);
                        if (deletedId != -1) {
                            Toast.makeText(getActivity(), "Delete Success...", Toast.LENGTH_LONG).show();
                        }
                    }
                })
                .setNegativeButton("No",new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        // if this button is clicked, just close
                        // the dialog box and do nothing
                        dialog.cancel();
                    }
                });

        // create alert dialog
        AlertDialog alertDialog = alertDialogBuilder.create();

        // show it
        alertDialog.show();
    }
}

