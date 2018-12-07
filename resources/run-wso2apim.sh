#!/bin/bash

set -ex

sed -ci.bak1 's|<!--HostName>www.wso2.org</HostName-->|<HostName>${WSO2_APIM_URL}</HostName>|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/carbon.xml ; \
sed -ci.bak1 's|<!--MgtHostName>mgt.wso2.org</MgtHostName-->|<MgtHostName>${WSO2_APIM_URL}</MgtHostName>|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/carbon.xml

exec $JAVA_APP_DIR/$WSO2_APIM_VERSION/bin/wso2server.sh