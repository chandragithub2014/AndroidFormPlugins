<?xml version="1.0"?>
<#import "root://activities/common/kotlin_macros.ftl" as kt>
<recipe>

    <@kt.addAllKotlinDependencies />
<dependency mavenUrl="com.android.support:support-v4:${buildApi}.+"/>
<dependency mavenUrl="com.android.support:recyclerview-v7:${buildApi}.+" />
<dependency mavenUrl="com.android.support:design:${buildApi}.+" />
<dependency mavenUrl="com.android.support:appcompat-v7:${buildApi}.+" />

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
        <instantiate from="root/res/layout/activity_wifi.xml"
                     to="${escapeXmlAttribute(resOut)}/layout/activity_wifi.xml" />
        <instantiate from="root/res/layout/fragment_wi_fi.xml"
                             to="${escapeXmlAttribute(resOut)}/layout/fragment_wi_fi.xml" />
 <instantiate from="root/res/layout/toolbar_custom_view.xml"
                             to="${escapeXmlAttribute(resOut)}/layout/toolbar_custom_view.xml" />

        
</#if>

<#if generateKotlin>
    <instantiate from="root/src/app_package/SimpleActivity.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.kt" />
<#else>
    <instantiate from="root/src/app_package/SimpleLoginActivity.java.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <open file="${escapeXmlAttribute(srcOut)}/${activityClass}.java" />
    <instantiate from="root/src/app_package/WifiActivity.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/WifiActivity.java" />
 <instantiate from="root/src/app_package/WiFIFragment.java.ftl"
                     to="${escapeXmlAttribute(srcOut)}/WiFIFragment.java" />

</#if>

</recipe>
