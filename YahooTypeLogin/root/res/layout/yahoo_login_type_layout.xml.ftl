<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:paddingBottom="@dimen/activity_vertical_margin"
    android:paddingLeft="@dimen/activity_horizontal_margin"
    android:paddingRight="@dimen/activity_horizontal_margin"
    android:paddingTop="@dimen/activity_vertical_margin"
    android:orientation="vertical"
    android:id="@+id/main_layout"
    android:background="#FFFFFF"
    android:weightSum="1"
	tools:context="${relativePackage}.${activityClass}">
<LinearLayout 
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:layout_weight="0.1">
    <ImageView
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:gravity="center"
        android:layout_marginTop="80dp"
        android:src="@drawable/ic_yahoo"
         />
    <RelativeLayout 
         android:layout_width="match_parent"
         android:layout_height="wrap_content"
         android:gravity="center"
          android:layout_marginTop="30dp"
        >
        <${relativePackage}.CustomEditText
            android:layout_width="400dp"
            android:layout_height="60dp"
            android:hint="User ID"
            android:id="@+id/yahoo_id"
            android:paddingLeft="10dp"
            android:paddingRight="10dp"
            android:background="@drawable/ic_border"
            />
        <${relativePackage}.CustomEditText
            android:layout_width="400dp"
            android:layout_height="60dp"
            android:layout_below="@id/yahoo_id"
            android:hint="Password"
            android:id="@+id/yahoo_pwd"
            android:background="@drawable/ic_border"
            android:paddingLeft="10dp"
            android:paddingRight="10dp"
           android:inputType="textPassword"
            />
        <Button 
         android:text="Sign In"
         android:textColor="#FFFFFF"
         android:layout_width="400dp"
         android:layout_height="60dp"
         android:id="@+id/yahoo_login"
         android:layout_marginTop="5dp"
         android:background="@drawable/buttonstyle"
         android:layout_below="@id/yahoo_pwd"
         />
    </RelativeLayout>
     <TextView
         android:layout_width="match_parent"
         android:layout_height="wrap_content"
         android:text="Forgot password or ID?"
         android:gravity="center_horizontal"
         android:layout_marginTop="10dp"
         android:visibility="gone"
         ></TextView>
     </LinearLayout>
    
      <LinearLayout 
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:layout_weight="0.9">
          <Button 
         android:text="Create Account"
         android:layout_width="400dp"
         android:layout_height="wrap_content"
         android:id="@+id/yahoo_create"
         android:layout_gravity="center"
         android:visibility="gone"
         />
     </LinearLayout>
</LinearLayout>




<!-- 

  <RelativeLayout
         android:layout_width="match_parent"
         android:layout_height="match_parent" 
         android:gravity="center"
         android:id="@+id/parent_layout"
         >
         <Button 
         android:text="Create Account"
         android:layout_width="200dp"
         android:layout_height="wrap_content"
         android:id="@+id/yahoo_create"
         android:layout_marginBottom="20dp"
         />
    </RelativeLayout>

 -->
