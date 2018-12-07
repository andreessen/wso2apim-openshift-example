FROM fabric8/java-jboss-openjdk8-jdk:1.5.1

ENV \
    AB_ENABLED=jolokia,jmx_exporter \
    AB_JOLOKIA_AUTH_OPENSHIFT=true \
    JAVA_OPTIONS=-Xmx1024m

RUN \
    set -e ; \
    echo ${JAVA_APP_DIR} ; \
    curl 'ftp://134.160.38.1/Linux/dag/redhat/el6/en/x86_64/testing/RPMS/collectd-5.0.1-1.el6.rft.x86_64.rpm' -o /tmp/3.rpm; \
    unzip -d $JAVA_APP_DIR /tmp/wso2_apim.zip ; \
    rm -rf /tmp/wso2_*.zip

EXPOSE 9443

CMD [ "$JAVA_APP_DIR/bin/wso2server.sh" ]
