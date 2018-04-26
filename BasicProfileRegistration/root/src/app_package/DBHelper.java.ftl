package ${packageName};

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteException;
import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


/**
 * Created by CHANDRASAIMOHAN on 1/15/2017.
 */

public class DBHelper {
    private final static String TAG = DBHelper.class.getSimpleName();
      public  int insertData(ContentValues cval,String tableName){
        int insertedRowId = -1;
        try {
            insertedRowId = (int) DBManager.getRegistrationDB().insert(tableName, null, cval);
            Log.d(TAG, "Inserted Row Id::::" + insertedRowId);
        }catch (SQLiteException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
        return  insertedRowId;
    }


 public List<String> fetchStateList(String query){
          List<String> stateList = new ArrayList<>();
try{
    Cursor transCursor = null;
    try{
        transCursor = DBManager.getRegistrationDB().query("countries", null,
                query, null, null, null, null);
        if(transCursor.moveToFirst()){
            do {
                stateList.add(transCursor.getString(transCursor.getColumnIndex("state")));
            }while(transCursor.moveToNext());
        }
    }catch (SQLiteException e){
        e.printStackTrace();
    }catch (Exception e){
        e.printStackTrace();
    }

}catch (SQLiteException e){
    e.printStackTrace();
}catch (Exception e){
    e.printStackTrace();
}
         return  stateList;
 }



    public int fetchDictionaryHistory(String tableName){
        Cursor registrationCursor = null;
        int id = -1;
        try {
            registrationCursor =  DBManager.getRegistrationDB().query (true, tableName,
                    null, null,
                    null,null,
                    null, null, null);
            if(registrationCursor!=null && registrationCursor.moveToFirst()){
                do{
                    id = registrationCursor.getInt(registrationCursor.getColumnIndex("_id"));
                }while (registrationCursor.moveToNext());
                registrationCursor.close();
            }
        }catch (SQLiteException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
        return  id;
    }



/*
mDb.query(true, DATABASE_NAMES_TABLE, new String[] { KEY_ROWID,
            KEY_NAME }, KEY_NAME + " LIKE ?",
            new String[] { filter+"%" }, null, null, null,
            null);
Will Lists all the records starting with word in filter.

mDb.query(true, DATABASE_NAMES_TABLE, new String[] { KEY_ROWID,
            KEY_NAME }, KEY_NAME + " LIKE ?",
            new String[] {"%"+ filter+ "%" }, null, null, null,
            null);
Will Lists all the records containing word in filter.
 */

/*
    public int updateData(SurveyDTO surveyDTO,String userId){
        int insertedRowId = -1;

        try {
            ContentValues cval = new ContentValues();
            cval.put("surveyid", surveyDTO.getSurveyID());
            cval.put("surveyname", surveyDTO.getSurveyName());
            cval.put("surveytype", surveyDTO.getSurveyType());
            cval.put("surveyquestion", surveyDTO.getSurveyQuestion());
            cval.put("surveyanswer", surveyDTO.getSurveyAnswer());
            cval.put("userid", userId);

//                   insertedRowId = (int) DBManager.getSurveyDB().update("filledsurvey", cval,"surveyquestion = ? and surveyid =?",new String[]{surveyDTO.getSurveyQuestion(), surveyDTO.getSurveyID()});
            insertedRowId = (int) DBManager.getSurveyDB().insert("filledsurvey", null,cval);
            Log.d(TAG, "Inserted Row Id::::" + insertedRowId);
        }catch (SQLiteException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }

        return  insertedRowId;
    }


    public  List<SurveyDTO> fetchSurveyInfo(){
        Cursor surveyCursor = null;
        HashMap<String,String> surveyInfo = new HashMap<>();
        SurveyDTO surveyDTO;
        List<SurveyDTO> surveyDTOList = new ArrayList<>();
        try {
            surveyCursor =  DBManager.getSurveyDB().query (true, "survey",
                    new String[] {"surveyname","surveyid"}, null,
                    null,null,
                    null, null, null);
            if(surveyCursor!=null && surveyCursor.moveToFirst()){
                do{
                    String surveyName = surveyCursor.getString(surveyCursor.getColumnIndex("surveyname"));
                    String surveyId = surveyCursor.getString(surveyCursor.getColumnIndex("surveyid"));
                    surveyDTO = new SurveyDTO();
                    surveyDTO.setSurveyName(surveyName);
                    surveyDTO.setSurveyID(surveyId);
                    surveyDTOList.add(surveyDTO);

                    surveyInfo.put(surveyName,surveyId);
                }while (surveyCursor.moveToNext());
                surveyCursor.close();
            }
        }catch (SQLiteException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
        return  surveyDTOList;
    }


    public List<SurveyDTO> getQuestionList(String surveyId){
        Cursor surveyCursor = null;
        SurveyDTO surveyDTO;
        List<SurveyDTO> surveyDTOList = new ArrayList<>();
        String SURVEY_ID = "surveyid";
        try{

            surveyCursor = DBManager.getSurveyDB().query(
                    "survey",
                    null,
                    SURVEY_ID + "="
                            + "'" + surveyId + "'", null, null, null, null);
            if(surveyCursor!=null && surveyCursor.moveToFirst()){
                do{
                    String surveyName = surveyCursor.getString(surveyCursor.getColumnIndex("surveyname"));
                    String surveyQuestion = surveyCursor.getString(surveyCursor.getColumnIndex("surveyquestion"));
                    String surveyID =  surveyCursor.getString(surveyCursor.getColumnIndex("surveyid"));
                    String surveyType =  surveyCursor.getString(surveyCursor.getColumnIndex("surveytype"));
                    surveyDTO = new SurveyDTO();
                    surveyDTO.setSurveyName(surveyName);
                    surveyDTO.setSurveyID(surveyID);
                    surveyDTO.setSurveyQuestion(surveyQuestion);
                    surveyDTO.setSurveyType(surveyType);
                    surveyDTOList.add(surveyDTO);

                }while (surveyCursor.moveToNext());
            }
        }catch (SQLiteException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }

        return surveyDTOList;
    }*/
}
