#!/bin/bash

set -ex

echo '>>>WSO2_APIM_URL = ${WSO2_APIM_URL}'
echo '>>>JAVA_APP_DIR = ${JAVA_APP_DIR}'

sed -ci.bak1 's|<!--HostName>www.wso2.org</HostName-->|<HostName>'"$WSO2_APIM_URL"'</HostName>|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/carbon.xml
sed -ci.bak1 's|<!--MgtHostName>mgt.wso2.org</MgtHostName-->|<MgtHostName>'"$WSO2_APIM_URL"'</MgtHostName>|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/carbon.xml
sed -ci.bak1 's|port="9443"|port="9443" proxyPort="443"|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/tomcat/catalina-server.xml
sed -ci.bak1 's|<GatewayEndpoint>http://${carbon.local.ip}:${http.nio.port},https://${carbon.local.ip}:${https.nio.port}</GatewayEndpoint>|<GatewayEndpoint>http://'"$WSO2_APIM_SANDBOX_URL"',https://'"$WSO2_APIM_PROD_URL"'</GatewayEndpoint>|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/api-manager.xml



cp $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/datasources/master-datasources.xml /tmp/master-datasources_.xml
xsltproc /tmp/append_ds.xslt /tmp/master-datasources_.xml > /tmp/master-datasources.xml
xsltproc --stringparam pApiMgtDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/apimgtdb?autoReconnect=true \
	--stringparam pApiMgtDBPassword "$MYSQL_PASSWORD" --stringparam pApiMgtDBUser "$MYSQL_USER" \
	--stringparam pMBDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/mbstoredb?autoReconnect=true \
	--stringparam pMBDBPassword "$MYSQL_PASSWORD" --stringparam pMBDBUser "$MYSQL_USER" \
	--stringparam pStatDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/statdb?autoReconnect=true \
	--stringparam pStatDBPassword "$MYSQL_PASSWORD" --stringparam pStatDBUser "$MYSQL_USER" \
	--stringparam pRegDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/regdb?autoReconnect=true \
	--stringparam pRegDBPassword "$MYSQL_PASSWORD" --stringparam pRegDBUser "$MYSQL_USER" \
	--stringparam pUMgtDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/userdb?autoReconnect=true  \
	--stringparam pUMgtDBPassword "$MYSQL_PASSWORD" --stringparam pUMgtDBUser "$MYSQL_USER" /tmp/master.xslt /tmp/master-datasources.xml > $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/datasources/master-datasources.xml

cp $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/user-mgt.xml /tmp/user-mgt.xml
xsltproc /tmp/append_umgt.xslt /tmp/user-mgt.xml > $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/user-mgt.xml

cp $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/registry.xml /tmp/registry.xml
xsltproc --stringparam pRegDBUrl "$MYSQL_USER"@jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/regdb /tmp/registry.xslt /tmp/registry.xml > $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/registry.xml

exec $JAVA_APP_DIR/$WSO2_APIM_VERSION/bin/wso2server.sh