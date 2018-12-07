#!/bin/bash

set -ex

echo '>>>WSO2_APIM_URL = ${WSO2_APIM_URL}'

sed -ci.bak1 's|<!--HostName>www.wso2.org</HostName-->|<HostName>'"$WSO2_APIM_URL"'</HostName>|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/carbon.xml ; \
sed -ci.bak1 's|<!--MgtHostName>mgt.wso2.org</MgtHostName-->|<MgtHostName>'"$WSO2_APIM_URL"'</MgtHostName>|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/carbon.xml
sed -ci.bak1 's|redirectPort="9443"|redirectPort="443"|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/tomcat/catalina-server.xml

exec $JAVA_APP_DIR/$WSO2_APIM_VERSION/bin/wso2server.sh