FROM azul/zulu-openjdk-alpine:11

LABEL maintainer="Naren Ravilla"

ARG CMAK_VERSION="3.0.0.5"
ARG ZK_HOSTS="zookeeper:2181"
ARG CMAK_CONFIGFILE="conf/application.conf"

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk/ \
	ZK_HOSTS=$ZK_HOSTS \
	CMAK_VERSION=$CMAK_VERSION \
	CMAK_CONFIGFILE=$CMAK_CONFIGFILE

WORKDIR /opt

RUN echo "ipv6" >> /etc/modules &&\
	apk add wget git wget unzip which curl tar &&\
	apk add --no-cache bash &&\
	wget https://github.com/yahoo/CMAK/releases/download/${CMAK_VERSION}/cmak-${CMAK_VERSION}.zip &&\
	unzip -d /opt cmak-${CMAK_VERSION}.zip

ADD start-cmak.sh /opt/cmak-${CMAK_VERSION}/start-cmak.sh

RUN touch /opt/cmak-${CMAK_VERSION}/cmak.pid &&\
	chmod +x /opt/cmak-${CMAK_VERSION}/start-cmak.sh

WORKDIR /opt/cmak-${CMAK_VERSION}

EXPOSE 9000

ENTRYPOINT ["./start-cmak.sh"]
