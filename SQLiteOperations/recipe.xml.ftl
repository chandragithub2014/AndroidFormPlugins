<?xml version="1.0"?>
<#import "root://activities/common/kotlin_macros.ftl" as kt>
<recipe>
    
    <@kt.addAllKotlinDependencies />
<dependency mavenUrl="com.android.support:support-v4:${buildApi}.+"/>
<dependency mavenUrl="com.android.support:recyclerview-v7:${buildApi}.+" />
<dependency mavenUrl="com.android.support:cardview-v7:${buildApi}.+" />
<dependency mavenUrl="com.android.support:design:${buildApi}.+" />

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
        <instantiate from="root/res/layout/fragment_profile_sqlite.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/fragment_profile_sqlite.xml" />
		<instantiate from="root/res/layout/fragment_simple_list_type1.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/fragment_simple_list_type1.xml" />	
        <instantiate from="root/res/layout/simple_row_type1.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/simple_row_type1.xml" />	
        <instantiate from="root/res/layout/toolbar_custom_view.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/toolbar_custom_view.xml" />		
        <instantiate from="root/res/layout/activity_fetch.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/activity_fetch.xml" />							 
		 			 
</#if>

<#if generateKotlin>
    <instantiate from="root/src/app_package/SimpleActivity.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
<#else>
    <instantiate from="root/src/app_package/ProfileRegistrationActivity.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <instantiate from="root/src/app_package/sqliteoperations/Create/SectionedRegistrationFragment.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/Create/SectionedRegistrationFragment.java" />
 <instantiate from="root/src/app_package/sqliteoperations/DBHelpers/DBHelper.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/DBHelpers/DBHelper.java" />
 <instantiate from="root/src/app_package/sqliteoperations/DBHelpers/DBManager.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/DBHelpers/DBManager.java" />
 <instantiate from="root/src/app_package/sqliteoperations/DTO/ColumnDTO.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/DTO/ColumnDTO.java" />	
<instantiate from="root/src/app_package/sqliteoperations/DTO/ProfileDTO.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/DTO/ProfileDTO.java" />						 
<instantiate from="root/src/app_package/sqliteoperations/Interfaces/ClickListener.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/Interfaces/ClickListener.java" />
<instantiate from="root/src/app_package/sqliteoperations/Retrieve/DividerItemDecoration.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/Retrieve/DividerItemDecoration.java" />	
<instantiate from="root/src/app_package/sqliteoperations/Retrieve/FetchActivity.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/Retrieve/FetchActivity.java" />		
<instantiate from="root/src/app_package/sqliteoperations/Retrieve/SimpleDTOType1.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/Retrieve/SimpleDTOType1.java" />	
<instantiate from="root/src/app_package/sqliteoperations/Retrieve/SimpleListType1Adapter.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/Retrieve/SimpleListType1Adapter.java" />						 
<instantiate from="root/src/app_package/sqliteoperations/Retrieve/SimpleListType1Fragment.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/Retrieve/SimpleListType1Fragment.java" />
<instantiate from="root/src/app_package/sqliteoperations/UpdateDelete/PrepopulatedSectionedRegistrationFragment.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/sqliteoperations/UpdateDelete/PrepopulatedSectionedRegistrationFragment.java" />					 
					 
					 
 				 
				 

</#if>
 <mkdir at="${escapeXmlAttribute(manifestOut)}/assets/" />
 <copy from="root/assets"
                     to="${escapeXmlAttribute(manifestOut)}/assets" />	
</recipe>
