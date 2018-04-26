package ${packageName};

import ${superClassFqcn};
import android.os.Bundle;
<#if includeCppSupport!false>
import android.widget.TextView;
</#if>

public class ${activityClass} extends ${superClass} {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.${layoutName});
        launchFragment();
    }
<#include "../../../../common/jni_code_snippet.java.ftl">

  private void launchFragment(){
   Fragment simpleLoginFrag = new YahooTypeLoginFragment();
               getSupportFragmentManager().beginTransaction()
                       .replace(R.id.frag_parentLayout, simpleLoginFrag)
                       .commit();
  }
}
