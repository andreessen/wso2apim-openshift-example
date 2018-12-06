FROM fabric8/java-jboss-openjdk8-jdk:1.5.1

ENV \
    WSO2_HOME=$WSO2_HOME \
    AB_ENABLED=off \
    AB_JOLOKIA_AUTH_OPENSHIFT=true \
    JAVA_OPTIONS=-Xmx1024m

RUN \
    set -e ; \
    curl -Lo /tmp/wso2_apim.zip https://wso2.com/api-management/install/binary/ ; \
    mkdir -p $WSO2_HOME/ ; \
    unzip -d $WSO2_HOME /tmp/wso2_apim.zip ; \
    rm -rf /tmp/wso2_*.zip

EXPOSE 9443

CMD [ "$WSO2_HOME/bin/wso2server.sh" ]