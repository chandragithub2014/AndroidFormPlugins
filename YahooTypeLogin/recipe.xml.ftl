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

<merge from="root/res/values/dimens.xml.ftl"
             to="${escapeXmlAttribute(resOut)}/values/dimens.xml" />
   <copy from="root/res/drawable"
            to="${escapeXmlAttribute(resOut)}/drawable" />
            <copy from="root/res/drawable-hdpi"
                     to="${escapeXmlAttribute(resOut)}/drawable-hdpi" />
              <copy from="root/res/drawable-mdpi"
                     to="${escapeXmlAttribute(resOut)}/drawable-mdpi" />
               <copy from="root/res/drawable-xhdpi"
                      to="${escapeXmlAttribute(resOut)}/drawable-xhdpi" />


<#if generateLayout>
      <instantiate from="root/res/layout/activity_simple_login.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/${layoutName}.xml" />
        <instantiate from="root/res/layout/yahoo_login_type_layout.xml.ftl"
                     to="${escapeXmlAttribute(resOut)}/layout/yahoo_login_type_layout.xml" />
</#if>

<#if generateKotlin>
    <instantiate from="root/src/app_package/SimpleActivity.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
<#else>
    <instantiate from="root/src/app_package/SimpleLoginActivity.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <instantiate from="root/src/app_package/YahooTypeLoginFragment.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/YahooTypeLoginFragment.java" />
	<instantiate from="root/src/app_package/CustomEditText.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/CustomEditText.java" />				 

</#if>

</recipe>
