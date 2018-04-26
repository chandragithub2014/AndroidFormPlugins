package ${packageName}.sqliteoperations.DBHelpers;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * Created by CHANDRASAIMOHAN on 1/13/2017.
 */

public class DBManager extends SQLiteOpenHelper {

    private final static String TAG = DBManager.class.getSimpleName();
    private static final String REGISTRATION_DB = "profileDB.db";
    private static SQLiteDatabase surveyDB;
    Context localContext;

    public DBManager(Context context) {
        super(context, "profileDB.db", null, 1);
        localContext = context;
    }

    public static SQLiteDatabase getRegistrationDB() {
        return surveyDB;
    }

    @Override
    public void onCreate(SQLiteDatabase db) {

    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

    }

    private void copySurveyDatabase() throws IOException {
        Log.i(TAG,
                "method copyConfigDatabase, copying configDB schema from local to device");

        InputStream inputStream = localContext.getAssets().open(
                REGISTRATION_DB);
        String outFileName = localContext.getDatabasePath(
                REGISTRATION_DB).toString();
        OutputStream outputStream = new FileOutputStream(outFileName);
        byte[] buffer = new byte[1024];
        int length;
        while ((length = inputStream.read(buffer)) > 0) {
            outputStream.write(buffer, 0, length);
        }
        outputStream.flush();
        outputStream.close();
        inputStream.close();
        this.close();
    }

    private boolean isRegistrationDBExists() {

		/*
         * SQLiteDatabase checkDB = null; try { checkDB =
		 * SQLiteDatabase.openDatabase( localContext.getDatabasePath(
		 * DatabaseConstants.CONFIG_DB_NAME).toString(), null,
		 * SQLiteDatabase.OPEN_READONLY); } catch (SQLiteException e) {
		 * Log.e(TAG, "Config DB does not exist"); } if (checkDB != null) {
		 * checkDB.close(); } return checkDB != null ? true : false;
		 */

        return new File(localContext.getDatabasePath(
                REGISTRATION_DB).toString()).isFile();
    }


    private void openRegistrationDBConnection() {
        Log.i(TAG, "Opening Config DB Connection");
        if (surveyDB == null || !surveyDB.isOpen()) {
            surveyDB = SQLiteDatabase.openDatabase(localContext
                    .getDatabasePath(REGISTRATION_DB)
                    .toString(), null, SQLiteDatabase.OPEN_READWRITE);
        }
    }


    private void createRegistrationDataBase() {
        Log.i(TAG, "method createConfigDataBase");
        boolean dbExist = isRegistrationDBExists();
        Log.i(TAG, "is survey DB exists- " + dbExist);
        if (dbExist) {
        } else {
            this.getReadableDatabase();
            try {
                copySurveyDatabase();
            } catch (IOException e) {
                Log.e(TAG,
                        "IOException occurred in method createRegistrationDataBase . Error is:"
                                + e.getMessage());
                e.printStackTrace();
            }
        }
        openRegistrationDBConnection();
    }

    public void load() {
        createRegistrationDataBase();
    }
}
