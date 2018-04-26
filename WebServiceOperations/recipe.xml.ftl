<?xml version="1.0"?>
<#import "root://activities/common/kotlin_macros.ftl" as kt>
<recipe>
    
    <@kt.addAllKotlinDependencies />
<dependency mavenUrl="com.android.support:support-v4:${buildApi}.+"/>
<dependency mavenUrl="com.android.support:recyclerview-v7:${buildApi}.+" />
<dependency mavenUrl="com.android.support:cardview-v7:${buildApi}.+" />
<dependency mavenUrl="com.android.support:design:${buildApi}.+" />
<dependency mavenUrl="com.github.bumptech.glide:glide:3.7.0" />
<dependency mavenUrl="com.android.volley:volley:1.0.0" />


<merge from="root/AndroidManifest.xml.ftl"
             to="${escapeXmlAttribute(manifestOut)}/AndroidManifest.xml" />
 <#if minApiLevel lt 13>
      <merge from="root/res/values-w900dp/refs.xml.ftl"
               to="${escapeXmlAttribute(resOut)}/values-w900dp/refs.xml" />
    </#if>
    <merge from="root/res/values/strings.xml.ftl"
             to="${escapeXmlAttribute(resOut)}/values/strings.xml" />

    <#if isInstantApp!false>
      <merge from="root/res/values/strings_iapp.xml.ftl"
               to="${escapeXmlAttribute(baseFeatureResOut)}/values/strings.xml" />
    <#else>
      <merge from="root/res/values/strings.xml.ftl"
               to="${escapeXmlAttribute(resOut)}/values/strings.xml" />
    </#if>

	<merge from="root/res/values/dimens.xml.ftl"
             to="${escapeXmlAttribute(resOut)}/values/dimens.xml" />
    <merge from="root/res/values/colors.xml.ftl"
             to="${escapeXmlAttribute(resOut)}/values/colors.xml" />
    <merge from="root/res/values/styles.xml.ftl"
             to="${escapeXmlAttribute(resOut)}/values/styles.xml" />
 <copy from="root/res/drawable"
            to="${escapeXmlAttribute(resOut)}/drawable" />
	


<#if generateLayout>
      <instantiate from="root/res/layout/activity_simple_login.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
        <instantiate from="root/res/layout/activity_hero_list.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/activity_hero_list.xml" />
		<instantiate from="root/res/layout/activity_main.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/activity_main.xml" />	
        <instantiate from="root/res/layout/simple_row_type1_webservice.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/simple_row_type1_webservice.xml" />	
        <instantiate from="root/res/layout/toolbar_custom_view.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/toolbar_custom_view.xml" />		
        <instantiate from="root/res/layout/fragment_simple_list_type1_web_service.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/fragment_simple_list_type1_web_service.xml" />							 
		 			 
</#if>

<#if generateKotlin>
    <instantiate from="root/src/app_package/SimpleActivity.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
<#else>
    <instantiate from="root/src/app_package/ProfileRegistrationActivity.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <instantiate from="root/src/app_package/webserviceoperations/ListHelpers/DividerItemDecoration.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/ListHelpers/DividerItemDecoration.java" />
 <instantiate from="root/src/app_package/webserviceoperations/ListHelpers/HeroListActivity.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/ListHelpers/HeroListActivity.java" />
 <instantiate from="root/src/app_package/webserviceoperations/ListHelpers/SimpleDTOType1.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/ListHelpers/SimpleDTOType1.java" />
 <instantiate from="root/src/app_package/webserviceoperations/ListHelpers/SimpleListType1Adapter.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/ListHelpers/SimpleListType1Adapter.java" />	
<instantiate from="root/src/app_package/webserviceoperations/ListHelpers/SimpleListType1Fragment.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/ListHelpers/SimpleListType1Fragment.java" />	
<instantiate from="root/src/app_package/webserviceoperations/interfaces/ResponseListener.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/interfaces/ResponseListener.java" />
<instantiate from="root/src/app_package/webserviceoperations/WebServiceHelpers/CustomJSONObjectRequest.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/WebServiceHelpers/CustomJSONObjectRequest.java" />	
<instantiate from="root/src/app_package/webserviceoperations/WebServiceHelpers/CustomVolleyRequestQueue.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/WebServiceHelpers/CustomVolleyRequestQueue.java" />		
<instantiate from="root/src/app_package/webserviceoperations/WebServiceHelpers/HeroDTO.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/WebServiceHelpers/HeroDTO.java" />	
<instantiate from="root/src/app_package/webserviceoperations/WebServiceHelpers/WebServiceHelper.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/webserviceoperations/WebServiceHelpers/WebServiceHelper.java" />	
</#if>
</recipe>
