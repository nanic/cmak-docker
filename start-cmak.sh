#!/bin/sh
echo $CMAK_VERSION
if [[ $CMAK_USERNAME != ''  && $CMAK_PASSWORD != '' ]]; then
    sed -i.bak '/^basicAuthentication/d' /opt/cmak-${CMAK_VERSION}/conf/application.conf
    echo 'basicAuthentication.enabled=true' >> /opt/cmak-${CMAK_VERSION}/conf/application.conf
    echo "basicAuthentication.username=${CMAK_USERNAME}" >> /opt/cmak-${CMAK_VERSION}/conf/application.conf
    echo "basicAuthentication.password=${CMAK_PASSWORD}" >> /opt/cmak-${CMAK_VERSION}/conf/application.conf
    echo 'basicAuthentication.realm="Kafka-Manager"' >> /opt/cmak-${CMAK_VERSION}/conf/application.conf
fi

exec ./bin/cmak -Dconfig.file=${CMAK_CONFIGFILE} "${CMAK_ARGS}" "${@}"
