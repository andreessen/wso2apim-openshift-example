FROM fabric8/java-jboss-openjdk8-jdk:1.5.1

ENV \
    AB_ENABLED=jolokia,jmx_exporter \
    AB_JOLOKIA_AUTH_OPENSHIFT=true \
    JAVA_OPTIONS=-Xmx1024m


USER root

RUN \
    yum install -y mysql && \
    yum clean all -y


USER jboss    


RUN \
    set -e ; \
    echo '>>>JAVA_APP_DIR = ${JAVA_APP_DIR}' && \
    echo '>>>WSO2_APIM_VERSION = ${WSO2_APIM_VERSION}' &&  \
    echo '>>>WSO2_APIM_DISTRIB_HOST = ${WSO2_APIM_DISTRIB_HOST}' &&  \
    curl http://${WSO2_APIM_DISTRIB_HOST}/${WSO2_APIM_VERSION}.zip -Lo /tmp/wso2_apim.zip &&  \
    unzip -d $JAVA_APP_DIR /tmp/wso2_apim.zip &&  \
    mkdir -p /tmp/repository/deployment/server &&  \
    cp -R $JAVA_APP_DIR/repository/deployment/server/* /tmp/repository/deployment/server &&  \
    rm -rf /tmp/wso2_*.zip &&  \
    mkdir $JAVA_APP_DIR/bin &&  \
    # add libraries for Kubernetes membership scheme based clustering - https://github.com/wso2/docker-apim/blob/2.6.x/dockerfiles/centos/apim/Dockerfile
    curl -Lo $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/components/lib/dnsjava-2.1.8.jar https://repo1.maven.org/maven2/dnsjava/dnsjava/2.1.8/dnsjava-2.1.8.jar &&  \
    curl -Lo $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/components/dropins/kubernetes-membership-scheme-1.0.5.jar https://repo1.maven.org/maven2/org/wso2/carbon/kubernetes/artifacts/kubernetes-membership-scheme/1.0.5/kubernetes-membership-scheme-1.0.5.jar &&  \
    curl -Lo /tmp/mysql-connector-java-5.1.34.zip https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.34.zip &&  \
    mkdir /tmp/mysql && \
    unzip -d /tmp/mysql /tmp/mysql-connector-java-5.1.34.zip &&  \
    cp /tmp/mysql/mysql-connector-java-5.1.34/mysql-connector-java-5.1.34-bin.jar $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/components/lib &&  \
    rm -rf /tmp/mysql &&  \
    chmod -R g+w $JAVA_APP_DIR/$WSO2_APIM_VERSION
    

CMD /bin/bash -c "/bin/bash $JAVA_APP_DIR/bin/run-wso2apim.sh"

EXPOSE 9443

COPY resources/run-wso2apim.sh $JAVA_APP_DIR/bin/
COPY resources/xslt/master.xslt /tmp
COPY resources/xslt/append_ds.xslt /tmp
COPY resources/xslt/registry.xslt /tmp
COPY resources/xslt/append_umgt.xslt /tmp