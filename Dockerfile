FROM fabric8/java-jboss-openjdk8-jdk:1.5.1

ENV \
    AB_ENABLED=jolokia,jmx_exporter \
    AB_JOLOKIA_AUTH_OPENSHIFT=true \
    JAVA_OPTIONS=-Xmx1024m \
    PATH="/opt/rh/rh-python36/root/usr/bin/:${PATH}"

USER root

RUN \
    yum install -y fix-permissions centos-release-scl-rh && \
    yum-config-manager --enable centos-sclo-rh-testing && \
    INSTALL_PKGS="rh-python36 rh-python36-python-pip" && \
    yum install -y --setopt=tsflags=nodocs --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

RUN source scl_source enable rh-python36 && \
    virtualenv /opt/app-root && \
    chown -R 1001:0 /opt/app-root && \
#    fix-permissions /opt/app-root && \
#    rpm-file-permissions && \
    pip install --upgrade pip && \
    pip install xq

USER jboss

RUN \
    set -e ; \
    echo '>>>JAVA_APP_DIR = ${JAVA_APP_DIR}' && \
    echo '>>>WSO2_APIM_VERSION = ${WSO2_APIM_VERSION}' &&  \
    echo '>>>WSO2_APIM_DISTRIB_HOST = ${WSO2_APIM_DISTRIB_HOST}' &&  \
    curl http://${WSO2_APIM_DISTRIB_HOST}/${WSO2_APIM_VERSION}.zip -Lo /tmp/wso2_apim.zip &&  \
    unzip -d $JAVA_APP_DIR /tmp/wso2_apim.zip &&  \
    rm -rf /tmp/wso2_*.zip &&  \
    mkdir $JAVA_APP_DIR/bin &&  \
    curl -Lo /tmp/mysql-connector-java-8.0.13.zip https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.34.zip &&  \
    mkdir /tmp/mysql && \
    unzip -d /tmp/mysql /tmp/mysql-connector-java-8.0.13.zip &&  \
    cp /tmp/mysql/mysql-connector-java-8.0.13/mysql-connector-java-8.0.13.jar $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/components/lib &&  \
    rm -rf /tmp/mysql &&  \
    chmod -R g+w $JAVA_APP_DIR/$WSO2_APIM_VERSION


RUN \
	mv $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/datasources/master-datasources.xml /tmp/master-datasources_.xml && \
	xsltproc /tmp/append_ds.xslt /tmp/master-datasources_.xml > /tmp/master-datasources.xml && \
	xsltproc --stringparam pApiMgtDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/apimgtdb?autoReconnect=true \
		--stringparam pApiMgtDBPassword "$MYSQL_PASSWORD" --stringparam pApiMgtDBUser "$MYSQL_USER" \
		--stringparam pMBDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/mbstoredb?autoReconnect=true \
		--stringparam pMBDBPassword "$MYSQL_PASSWORD" --stringparam pMBDBUser "$MYSQL_USER" \
		--stringparam pStatDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/statdb?autoReconnect=true \
		--stringparam pStatDBPassword "$MYSQL_PASSWORD" --stringparam pStatDBUser "$MYSQL_USER" \
		--stringparam pRegDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/regdb?autoReconnect=true \
		--stringparam pRegDBPassword "$MYSQL_PASSWORD" --stringparam pRegDBUser "$MYSQL_USER" \
		--stringparam pUMgtDBUrl jdbc:mysql://"$MYSQL_SERVICE_HOST":3306/userdb?autoReconnect=true  \
		--stringparam pUMgtDBPassword "$MYSQL_PASSWORD" --stringparam pUMgtDBUser "$MYSQL_USER" /tmp/master.xslt /tmp/master-datasources.xml > $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/datasources/master-datasources.xml && \
	mv $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/user-mgt.xml /tmp/user-mgt.xml && \
	xsltproc /tmp/append_umgt.xslt /tmp/user-mgt.xml > $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/user-mgt.xml && \
	mv $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/registry.xml /tmp/registry.xml && \
	xsltproc /tmp/registry.xslt /tmp/registry.xml > $JAVA_APP_DIR/${WSO2_APIM_VERSION}/repository/conf/registry.xml    
    

CMD /bin/bash -c "/bin/bash $JAVA_APP_DIR/bin/run-wso2apim.sh"

EXPOSE 9443

COPY resources/run-wso2apim.sh $JAVA_APP_DIR/bin/
COPY resources/xslt/master.xslt /tmp
COPY resources/xslt/append_ds.xslt /tmp
COPY resources/xslt/registry.xslt /tmp
COPY resources/xslt/append_umgt.xslt /tmp