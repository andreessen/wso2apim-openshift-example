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
    mkdir $JAVA_APP_DIR/bin ; \
    curl -Lo /tmp/mysql-connector-java-8.0.13.zip https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.13.zip ; \
    mkdir $JAVA_APP_DIR/mysql; \
    unzip -d $JAVA_APP_DIR/mysql /tmp/mysql-connector-java-8.0.13.zip; \
    cp /tmp/mysql/mysql-connector-java-8.0.13/mysql-connector-java-8.0.13.jar $JAVA_APP_DIR//${WSO2_APIM_VERSION}/repository/components/lib ; \
    rm -rf /tmp/mysql/mysql-connector-java-8.0.13*; \
    chmod -R g+w $JAVA_APP_DIR/$WSO2_APIM_VERSION
    

CMD /bin/bash -c "/bin/bash $JAVA_APP_DIR/bin/run-wso2apim.sh"

EXPOSE 9443

COPY resources/run-wso2apim.sh $JAVA_APP_DIR/bin/