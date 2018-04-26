package ${packageName}.sqliteoperations.DBHelpers;
import android.content.ContentValues;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteException;
import android.util.Log;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ${packageName}.sqliteoperations.AESHelpers.AESUtil;
import ${packageName}.sqliteoperations.DTO.ColumnDTO;


/**
 * Created by CHANDRASAIMOHAN on 1/15/2017.
 */

public class DBHelper {
    private final static String TAG = DBHelper.class.getSimpleName();

    public int insertData(ContentValues cval, String tableName) {
        int insertedRowId = -1;
        try {
            insertedRowId = (int) DBManager.getRegistrationDB().insert(tableName, null, cval);
            Log.d(TAG, "Inserted Row Id::::" + insertedRowId);
        } catch (SQLiteException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return insertedRowId;
    }
//Encrypted Methods

    public int insertEncryptedData(ContentValues cval, String tableName) {
        int insertedRowId = -1;
        try {
            insertedRowId = (int) DBManager.getRegistrationDB().insert(tableName, null, cval);
            Log.d(TAG, "Inserted Row Id::::" + insertedRowId);
        } catch (SQLiteException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return insertedRowId;
    }


    //Query

    public  List<Map<String,Object>> queryInfoInDecryptedFormat(String tableName){
        Map<String,Object> profileMap = new HashMap<>();
        List<Map<String,Object>> rowList = new ArrayList<>();
        Cursor queryCursor = null;
        try{

            List<ColumnDTO> columnList = fetchColumnList(tableName);

            queryCursor = DBManager.getRegistrationDB().query(tableName, null,
                    null, null, null, null, null);
            if(queryCursor.moveToFirst()){
                do{
                    if(columnList!=null && columnList.size()>0){
                        for(int i=0;i<columnList.size();i++){
                            ColumnDTO temp = columnList.get(i);
                            if(temp.getColumnType().equalsIgnoreCase("TEXT")){
                                if(queryCursor.getString(queryCursor.getColumnIndex(temp.getColumnName()))!=null) {
                                    profileMap.put(temp.getColumnName(), AESUtil.getDecodedString(queryCursor.getString(queryCursor.getColumnIndex(temp.getColumnName()))));
                                }else{
                                    profileMap.put(temp.getColumnName(),"");
                                }
                            }else if(temp.getColumnType().equalsIgnoreCase("INTEGER")){
                                if(temp.getColumnName().equalsIgnoreCase("_id")){
                                    profileMap.put(temp.getColumnName(), queryCursor.getInt(queryCursor.getColumnIndex(temp.getColumnName())));
                                }else {
                                    String encryptedData = "" + queryCursor.getInt(queryCursor.getColumnIndex(temp.getColumnName()));
                                    profileMap.put(temp.getColumnName(), AESUtil.getDecodedString(encryptedData));
                                }

                            }else if(temp.getColumnType().equalsIgnoreCase("REAL")){
                                String encyptedRealData =  ""+queryCursor.getDouble(queryCursor.getColumnIndex(temp.getColumnName()));
                                profileMap.put(temp.getColumnName(), AESUtil.getDecodedString(encyptedRealData));
                            }
                        }
                        rowList.add(profileMap);
                        profileMap = new HashMap<>();
                    }

                }while (queryCursor.moveToNext());
            }


        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }

        return  rowList;
    }

    //Query End

    //Retrieve DEcrypted
    public  Map<String,Object>  retrieveDecryptedRowDataBasedOnColumn(String tableName,String columnName,String columnValue){
        Map<String,Object> rowMap = new HashMap<>();
        try{
            Cursor queryCursor = null;

            List<ColumnDTO> columnList = fetchColumnList(tableName);
            ColumnDTO columnDTO = null;
            if(columnList!=null && columnList.size()>0){
                columnDTO = fetchMatchedColumnInfo(columnList,columnName);
                if(columnDTO!=null){
                    if(columnName.equalsIgnoreCase("_id")){
                        queryCursor = DBManager.getRegistrationDB().query(
                                tableName,
                                null,
                                columnName + "="
                                        + "'" + columnValue + "'", null, null, null, null);
                    }else {
                        queryCursor = DBManager.getRegistrationDB().query(
                                tableName,
                                null,
                                columnName + "="
                                        + "'" + AESUtil.getEncodedString(columnValue) + "'", null, null, null, null);
                    }

                    if(queryCursor!=null && queryCursor.moveToFirst()){
                        if(columnList!=null && columnList.size()>0){
                            for(int i=0;i<columnList.size();i++){
                                ColumnDTO temp = columnList.get(i);
                                if(temp.getColumnType().equalsIgnoreCase("TEXT")){
                                    if(queryCursor.getString(queryCursor.getColumnIndex(temp.getColumnName()))!=null) {
                                        Log.d("Helper","Column Name::::"+temp.getColumnName());
                                        rowMap.put(temp.getColumnName(),AESUtil.getDecodedString(queryCursor.getString(queryCursor.getColumnIndex(temp.getColumnName()))));
                                    }else{
                                        rowMap.put(temp.getColumnName(),"");
                                    }
                                }else if(temp.getColumnType().equalsIgnoreCase("INTEGER")){
                                    if(temp.getColumnName().equalsIgnoreCase("_id")){
                                        rowMap.put(temp.getColumnName(), queryCursor.getInt(queryCursor.getColumnIndex(temp.getColumnName())));
                                    }else {
                                        String encryptedIntData = "" + queryCursor.getInt(queryCursor.getColumnIndex(temp.getColumnName()));
                                        rowMap.put(temp.getColumnName(), AESUtil.getDecodedString(encryptedIntData));
                                    }

                                }else if(temp.getColumnType().equalsIgnoreCase("REAL")){
                                    String encryptedDoubleData = ""+queryCursor.getDouble(queryCursor.getColumnIndex(temp.getColumnName()));
                                    rowMap.put(temp.getColumnName(),AESUtil.getDecodedString(encryptedDoubleData));
                                }
                            }
                        }
                    }
                }
            }
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
        return  rowMap;
    }


    //End

    public int updateEncryptedData(String tableName,ContentValues cval,String columnName,String colVal) {
        int updatedRowId = -1;
        try {
            updatedRowId = (int) DBManager.getRegistrationDB().update(tableName,
                    cval, columnName + "= ? ",
                    new String[] { colVal });
        } catch (SQLException e) {
            Log.e(TAG,
                    "Error occurred in method updateTransData for input parameter rowId["
                            + colVal + "], tableName[" + tableName
                            + "]. Error is:" + e.getMessage());

        } catch (IllegalArgumentException e) {
            Log.e(TAG,
                    "Error occurred in method updateTransData for input parameter rowId["
                            + colVal + "], tableName[" + tableName
                            + "]. Error is:" + e.getMessage());

        }
        return updatedRowId;
    }


    public Integer deleteEncryptedData(String tableName,String columnName,String colVal) {
        long deleteRow = -1;
        try {
            if(columnName.equalsIgnoreCase("_id")){
                deleteRow = DBManager.getRegistrationDB().delete(tableName,
                        columnName + "= ? ",
                        new String[]{colVal});
            }else {
                deleteRow = DBManager.getRegistrationDB().delete(tableName,
                        columnName + "= ? ",
                        new String[]{AESUtil.getEncodedString(colVal)});
            }
        } catch (SQLException e) {
            Log.e(TAG,
                    "Error occurred in method deleteTransData for input parameter rowId["
                            + columnName + "], tableName[" + tableName
                            + "]. Error is:" + e.getMessage());
        }
        return (int) deleteRow;
    }

    //End

    public List<Map<String,Object>> queryInfo(String tableName){
        Map<String,Object> profileMap = new HashMap<>();
        List<Map<String,Object>> rowList = new ArrayList<>();
        Cursor queryCursor = null;
        try{

            List<ColumnDTO> columnList = fetchColumnList(tableName);

            queryCursor = DBManager.getRegistrationDB().query(tableName, null,
                    null, null, null, null, null);
            if(queryCursor.moveToFirst()){
                do{
                    if(columnList!=null && columnList.size()>0){
                        for(int i=0;i<columnList.size();i++){
                            ColumnDTO temp = columnList.get(i);
                            if(temp.getColumnType().equalsIgnoreCase("TEXT")){
                              if(queryCursor.getString(queryCursor.getColumnIndex(temp.getColumnName()))!=null) {
                                  profileMap.put(temp.getColumnName(),queryCursor.getString(queryCursor.getColumnIndex(temp.getColumnName())));
                              }else{
                                  profileMap.put(temp.getColumnName(),"");
                              }
                            }else if(temp.getColumnType().equalsIgnoreCase("INTEGER")){
                                    profileMap.put(temp.getColumnName(),queryCursor.getInt(queryCursor.getColumnIndex(temp.getColumnName())));

                            }else if(temp.getColumnType().equalsIgnoreCase("REAL")){
                                profileMap.put(temp.getColumnName(),queryCursor.getInt(queryCursor.getColumnIndex(temp.getColumnName())));
                            }
                        }
                        rowList.add(profileMap);
                        profileMap = new HashMap<>();
                    }

                }while (queryCursor.moveToNext());
            }


        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }

        return  rowList;
    }
    // Pragma Table_Info Constants
    public static final String PRAGMA_COLUMN_NAME1 = "name";
    public static final String PRAGMA_COLUMN_NAME2 = "type";
   private List<ColumnDTO> fetchColumnList(String tableName){
        List<ColumnDTO> colList = new ArrayList<>();

       Cursor pragmaCursor = null;
       pragmaCursor = DBManager.getRegistrationDB().rawQuery(
               "pragma table_info(" + tableName + ");", null);
       if (pragmaCursor.getCount() > 0) {
           if (pragmaCursor.moveToFirst()) {
               do {
                   ColumnDTO temp = new ColumnDTO();
                   temp.setColumnName(pragmaCursor.getString(pragmaCursor
                           .getColumnIndex(PRAGMA_COLUMN_NAME1)));
                   temp.setColumnType(pragmaCursor.getString(pragmaCursor
                           .getColumnIndex(PRAGMA_COLUMN_NAME2)));
                   colList.add(temp);
               } while (pragmaCursor.moveToNext());
           }
       }
       pragmaCursor.close();

   return  colList;
   }


   public Map<String,Object> retrieveRowDataBasedOnColumn(String tableName, String columnName, String columnValue){
       Map<String,Object> rowMap = new HashMap<>();
       try{
           Cursor queryCursor = null;

           List<ColumnDTO> columnList = fetchColumnList(tableName);
           ColumnDTO columnDTO = null;
           if(columnList!=null && columnList.size()>0){
               columnDTO = fetchMatchedColumnInfo(columnList,columnName);
                if(columnDTO!=null){
                    queryCursor =      DBManager.getRegistrationDB().query(
                            tableName,
                            null,
                            columnName + "="
                                    + "'" + columnValue + "'", null, null, null, null);
                   /*if(columnDTO.getColumnType().equalsIgnoreCase("TEXT")){
                       queryCursor =      DBManager.getRegistrationDB().query(
                               tableName,
                               null,
                               columnName + "="
                                       + "'" + columnValue + "'", null, null, null, null);
                   }else if(columnDTO.getColumnType().equalsIgnoreCase("INTEGER")){
                       queryCursor =      DBManager.getRegistrationDB().query(
                               tableName,
                               null,
                               columnName + "="
                                       + "' + columnValue + '", null, null, null, null);
                   }else if(columnDTO.getColumnType().equalsIgnoreCase("REAL")){
                       queryCursor =      DBManager.getRegistrationDB().query(
                               tableName,
                               null,
                               columnName + "="
                                       + "' + columnValue + '", null, null, null, null);
                   }*/
                   if(queryCursor!=null && queryCursor.moveToFirst()){
                       if(columnList!=null && columnList.size()>0){
                           for(int i=0;i<columnList.size();i++){
                               ColumnDTO temp = columnList.get(i);
                               if(temp.getColumnType().equalsIgnoreCase("TEXT")){
                                   if(queryCursor.getString(queryCursor.getColumnIndex(temp.getColumnName()))!=null) {
                                       rowMap.put(temp.getColumnName(),queryCursor.getString(queryCursor.getColumnIndex(temp.getColumnName())));
                                   }else{
                                       rowMap.put(temp.getColumnName(),"");
                                   }
                               }else if(temp.getColumnType().equalsIgnoreCase("INTEGER")){
                                   rowMap.put(temp.getColumnName(),queryCursor.getInt(queryCursor.getColumnIndex(temp.getColumnName())));

                               }else if(temp.getColumnType().equalsIgnoreCase("REAL")){
                                   rowMap.put(temp.getColumnName(),queryCursor.getInt(queryCursor.getColumnIndex(temp.getColumnName())));
                               }
                           }
                       }
                   }
                }
           }
       }catch (SQLException e){
           e.printStackTrace();
       }catch (Exception e){
           e.printStackTrace();
       }
return  rowMap;
   }
 public int update(String tableName, ContentValues cval, String columnName, String colVal) {
       int updatedRowId = -1;
   try {
       updatedRowId = (int) DBManager.getRegistrationDB().update(tableName,
                cval, columnName + "= ? ",
                new String[] { colVal });
    } catch (SQLException e) {
        Log.e(TAG,
                "Error occurred in method updateTransData for input parameter rowId["
                        + colVal + "], tableName[" + tableName
                        + "]. Error is:" + e.getMessage());

    } catch (IllegalArgumentException e) {
        Log.e(TAG,
                "Error occurred in method updateTransData for input parameter rowId["
                        + colVal + "], tableName[" + tableName
                        + "]. Error is:" + e.getMessage());

    }
     return updatedRowId;
 }



    public Integer delete(String tableName, String columnName, String colVal) {
        long deleteRow = -1;
        try {
            deleteRow = DBManager.getRegistrationDB().delete(tableName,
                    columnName + "= ? ",
                    new String[] { colVal });
        } catch (SQLException e) {
            Log.e(TAG,
                    "Error occurred in method deleteTransData for input parameter rowId["
                            + columnName + "], tableName[" + tableName
                            + "]. Error is:" + e.getMessage());
        }
        return (int) deleteRow;
    }

   private  ColumnDTO fetchMatchedColumnInfo(List<ColumnDTO> columnList, String columnName){
       ColumnDTO columnDTO  = null;
       for(int i=0;i<columnList.size();i++){
           if(columnName.equalsIgnoreCase(columnList.get(i).getColumnName())){
               columnDTO = columnList.get(i);
               break;
           }
       }

       return  columnDTO;
   }
    public List<String> fetchStateList(String query) {
        List<String> stateList = new ArrayList<>();
        try {
            Cursor transCursor = null;
            try {
                transCursor = DBManager.getRegistrationDB().query("countries", null,
                        query, null, null, null, null);
                if (transCursor.moveToFirst()) {
                    do {
                        stateList.add(transCursor.getString(transCursor.getColumnIndex("state")));
                    } while (transCursor.moveToNext());
                }
            } catch (SQLiteException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }

        } catch (SQLiteException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stateList;
    }







}
