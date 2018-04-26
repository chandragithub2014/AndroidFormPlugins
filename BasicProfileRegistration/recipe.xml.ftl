<?xml version="1.0"?>
<#import "root://activities/common/kotlin_macros.ftl" as kt>
<recipe>
    <#include "../common/recipe_manifest.xml.ftl" />
    <@kt.addAllKotlinDependencies />
<dependency mavenUrl="com.android.support:support-v4:${buildApi}.+"/>
<dependency mavenUrl="com.android.support:recyclerview-v7:${buildApi}.+" />
<dependency mavenUrl="com.android.support:design:${buildApi}.+" />

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

    <merge from="root/res/values/colors.xml.ftl"
             to="${escapeXmlAttribute(resOut)}/values/colors.xml" />
 <copy from="root/res/drawable"
            to="${escapeXmlAttribute(resOut)}/drawable" />
<copy from="root/res/mipmap-hdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-hdpi" />
<copy from="root/res/mipmap-mdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-mdpi" />
<copy from="root/res/mipmap-xhdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-xhdpi" />
<copy from="root/res/mipmap-xxhdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-xxhdpi" />
<copy from="root/res/mipmap-xxxhdpi"
            to="${escapeXmlAttribute(resOut)}/mipmap-xxxhdpi" />			


<#if generateLayout>
      <instantiate from="root/res/layout/activity_simple_login.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
        <instantiate from="root/res/layout/registrationform.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/registrationform.xml" />
		 <instantiate from="root/res/layout/spinner_row.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/spinner_row.xml" />
         <instantiate from="root/res/layout/spinner_row_2.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/spinner_row_2.xml" />					 
</#if>

<#if generateKotlin>
    <instantiate from="root/src/app_package/SimpleActivity.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
<#else>
    <instantiate from="root/src/app_package/ProfileRegistrationActivity.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <instantiate from="root/src/app_package/BasicRegistrationFragment.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/BasicRegistrationFragment.java" />
 <instantiate from="root/src/app_package/DBHelper.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/DBHelper.java" />
 <instantiate from="root/src/app_package/DBManager.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/DBManager.java" />					 
				 

</#if>
 <mkdir at="${escapeXmlAttribute(manifestOut)}/assets/" />
 <copy from="root/assets"
                     to="${escapeXmlAttribute(manifestOut)}/assets" />	
</recipe>
