FROM fabric8/java-jboss-openjdk8-jdk:1.5.1

ENV \
    AB_ENABLED=jolokia,jmx_exporter \
    AB_JOLOKIA_AUTH_OPENSHIFT=true \
    JAVA_OPTIONS=-Xmx1024m


RUN \
    set -e ; \
    echo '>>>JAVA_APP_DIR = ${JAVA_APP_DIR}' ; \
    echo '>>>WSO2_APIM_VERSION = ${WSO2_APIM_VERSION}' ; \
    echo '>>>WSO2_APIM_DISTRIB_HOST = ${WSO2_APIM_DISTRIB_HOST}' ; \
    curl http://${WSO2_APIM_DISTRIB_HOST}/${WSO2_APIM_VERSION}.zip -Lo /tmp/wso2_apim.zip; \
    unzip -d $JAVA_APP_DIR /tmp/wso2_apim.zip ; \
    rm -rf /tmp/wso2_*.zip ; \
    chmod -R g+w $JAVA_APP_DIR/$WSO2_APIM_VERSION ; \
    sed -ci.bak1 's|<!--HostName>www.wso2.org</HostName-->|<HostName>$WSO2_APIM_URL</HostName>|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/carbon.xml ; \
    sed -ci.bak1 's|<!--MgtHostName>mgt.wso2.org</MgtHostName-->|<MgtHostName>$WSO2_APIM_URL</MgtHostName>|' $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/carbon.xml

EXPOSE 9443

CMD [ "$JAVA_APP_DIR/$WSO2_APIM_VERSION/bin/wso2server.sh" ]
