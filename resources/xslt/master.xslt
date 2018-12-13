<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 <xsl:strip-space elements="*"/>

 <xsl:param name="pApiMgtDBUrl" />
 <xsl:param name="pApiMgtDBUser" />
 <xsl:param name="pApiMgtDBPassword" />

 <xsl:param name="pUMgtDBUrl" />
 <xsl:param name="pUMgtDBUser" />
 <xsl:param name="pUMgtDBPassword" />

  <xsl:param name="pRegDBUrl" />
 <xsl:param name="pRegDBUser" />
 <xsl:param name="pRegDBPassword" />

   <xsl:param name="pStatDBUrl" />
 <xsl:param name="pStatDBUser" />
 <xsl:param name="pStatDBPassword" />

    <xsl:param name="pMBDBUrl" />
 <xsl:param name="pMBDBUser" />
 <xsl:param name="pMBDBPassword" />

 <xsl:param name="pDriverClassName" select="'com.mysql.jdbc.Driver'"/>

 <xsl:template match="node()|@*">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*"/>
     </xsl:copy>
 </xsl:template>

 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2AM_DB"]/definition/configuration/url/text()'>
  <xsl:value-of select="$pApiMgtDBUrl"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2AM_DB"]/definition/configuration/driverClassName/text()'>
  <xsl:value-of select="$pDriverClassName"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2AM_DB"]/definition/configuration/username/text()'>
  <xsl:value-of select="$pApiMgtDBUser"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2AM_DB"]/definition/configuration/password/text()'>
  <xsl:value-of select="$pApiMgtDBPassword"/>
 </xsl:template>


  <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2UM_DB"]/definition/configuration/url/text()'>
  <xsl:value-of select="$pUMgtDBUrl"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2UM_DB"]/definition/configuration/driverClassName/text()'>
  <xsl:value-of select="$pDriverClassName"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2UM_DB"]/definition/configuration/username/text()'>
  <xsl:value-of select="$pUMgtDBUser"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2UM_DB"]/definition/configuration/password/text()'>
  <xsl:value-of select="$pUMgtDBPassword"/>
 </xsl:template>


  <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2REG_DB"]/definition/configuration/url/text()'>
  <xsl:value-of select="$pRegDBUrl"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2REG_DB"]/definition/configuration/driverClassName/text()'>
  <xsl:value-of select="$pDriverClassName"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2REG_DB"]/definition/configuration/username/text()'>
  <xsl:value-of select="$pRegDBUser"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2REG_DB"]/definition/configuration/password/text()'>
  <xsl:value-of select="$pRegDBPassword"/>
 </xsl:template>

   <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2AM_STATS_DB"]/definition/configuration/url/text()'>
  <xsl:value-of select="$pStatDBUrl"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2AM_STATS_DB"]/definition/configuration/driverClassName/text()'>
  <xsl:value-of select="$pDriverClassName"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2AM_STATS_DB"]/definition/configuration/username/text()'>
  <xsl:value-of select="$pStatDBUser"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2AM_STATS_DB"]/definition/configuration/password/text()'>
  <xsl:value-of select="$pStatDBPassword"/>
 </xsl:template>

 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2_MB_STORE_DB"]/definition/configuration/url/text()'>
  <xsl:value-of select="$pMBDBUrl"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2_MB_STORE_DB"]/definition/configuration/driverClassName/text()'>
  <xsl:value-of select="$pDriverClassName"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2_MB_STORE_DB"]/definition/configuration/username/text()'>
  <xsl:value-of select="$pMBDBUser"/>
 </xsl:template>
 <xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2_MB_STORE_DB"]/definition/configuration/password/text()'>
  <xsl:value-of select="$pMBDBPassword"/>
 </xsl:template>

</xsl:stylesheet>