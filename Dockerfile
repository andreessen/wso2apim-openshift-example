FROM fabric8/java-jboss-openjdk8-jdk:1.5.1

ENV \
    AB_ENABLED=jolokia,jmx_exporter \
    AB_JOLOKIA_AUTH_OPENSHIFT=true \
    JAVA_OPTIONS=-Xmx1024m

RUN \
    set -e ; \
    echo ${JAVA_APP_DIR} ; \
    curl http://sb57.emdev.ru/wso2am-2.6.0.zip -Lo /tmp/wso2_apim.zip; \
    unzip -d $JAVA_APP_DIR /tmp/wso2_apim.zip ; \
    rm -rf /tmp/wso2_*.zip ; \
    chmod g+w $JAVA_APP_DIR/wso2am-2.6.0

EXPOSE 9443

CMD [ "/deployments/wso2am-2.6.0/bin/wso2server.sh" ]
