<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 <xsl:strip-space elements="*"/>


 <xsl:template match="node()|@*">
     <xsl:copy>
       <xsl:apply-templates select="node()|@*"/>
     </xsl:copy>
 </xsl:template>

<xsl:template match='/datasources-configuration/datasources/datasource[name/text()="WSO2_MB_STORE_DB"]'>
  <xsl:copy>
            <!-- And everything inside it -->
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
  <datasource>
 <name>WSO2UM_DB</name>
 <description>The datasource used by user manager</description>
 <jndiConfig>
   <name>jdbc/WSO2UM_DB</name>
 </jndiConfig>
 <definition type="RDBMS">
   <configuration>
     <url>jdbc:mysql://db.mysql-wso2.com:3306/userdb?autoReconnect=true</url>
     <username>user</username>
     <password>password</password>
     <driverClassName>com.mysql.jdbc.Driver</driverClassName>
     <maxActive>50</maxActive>
     <maxWait>60000</maxWait>
     <testOnBorrow>true</testOnBorrow>
     <validationQuery>SELECT 1</validationQuery>
     <validationInterval>30000</validationInterval>
   </configuration>
 </definition>
</datasource>
<datasource>
 <name>WSO2REG_DB</name>
 <description>The datasource used by the registry</description>
 <jndiConfig>
   <name>jdbc/WSO2REG_DB</name>
 </jndiConfig>
 <definition type="RDBMS">
   <configuration>
     <url>jdbc:mysql://db.mysql-wso2.com:3306/regdb?autoReconnect=true</url>
     <username>user</username>
     <password>password</password>
     <driverClassName>com.mysql.jdbc.Driver</driverClassName>
     <maxActive>50</maxActive>
     <maxWait>60000</maxWait>
     <testOnBorrow>true</testOnBorrow>
     <validationQuery>SELECT 1</validationQuery>
     <validationInterval>30000</validationInterval>
   </configuration>
 </definition>
</datasource>
 </xsl:template>

</xsl:stylesheet>