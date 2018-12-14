<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output indent="yes" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>


	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="node()|@*"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template match='/wso2registry/dbConfig[@name="wso2registry"]'>
		<xsl:copy>
			<!-- And everything inside it -->
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
		<dbConfig name="govregistry">
			<dataSource>jdbc/WSO2REG_DB</dataSource>
		</dbConfig>
		<remoteInstance url="https://localhost:9443/registry">
			<id>gov</id>
			<cacheId>user@jdbc:mysql://db.mysql-wso2.com:3306/regdb</cacheId>
			<dbConfig>govregistry</dbConfig>
			<readOnly>false</readOnly>
			<enableCache>true</enableCache>
			<registryRoot>/</registryRoot>
		</remoteInstance>
		<mount overwrite="true" path="/_system/governance">
			<instanceId>gov</instanceId>
			<targetPath>/_system/governance</targetPath>
		</mount>
		<mount overwrite="true" path="/_system/config">
			<instanceId>gov</instanceId>
			<targetPath>/_system/config</targetPath>
		</mount>
	</xsl:template>
</xsl:stylesheet>