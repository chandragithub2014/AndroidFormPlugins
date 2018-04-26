
package ${packageName}.sqliteoperations.AESHelpers;

import android.util.Log;



/**
 * Created by 245742 on 6/10/2016.
 */
public class AESUtil {
  private static  String key = "342354354353453458AMNWGHJQGWHGWHJHVFEVFHWEFGHJWEGFEHJWGHGF64365!!!348743$%&&*&(&(*hjrgtrehjkterhtker";


    public static String getDecodedString(String toDecodedString){
        String decodedString = "";
        try {
            AESHelper aesHelper = new AESHelper();

            decodedString = aesHelper.decode(key, toDecodedString);
        }catch (Exception e){
            e.printStackTrace();
        }
        return decodedString;
    }

    public static String getEncodedString(String toBeEncodedString){
        String encodedString = "";
        try {
            AESHelper aesHelper = new AESHelper();

            encodedString  = aesHelper.encode(key, toBeEncodedString);
           
        }catch (Exception e){
            e.printStackTrace();
        }
        return encodedString;
    }

   /* public static  void main(String[] args){
        System.out.print(AESUtil.getDecodedString("h5mB88zPf6csxqfXtEaw0dkNk0s7\\/kbvwKnhzz8MrgU="));
    }*/
}
