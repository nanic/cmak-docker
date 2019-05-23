FROM openjdk:8-jdk-alpine

MAINTAINER Naren <nanichowdary.ravilla@gmail.com>

ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk/ \
	ZK_HOSTS=localhost:2181\
	KM_VERSION=2.0.0.2\
	KM_CONFIGFILE="conf/application.conf"

RUN echo "ipv6" >> /etc/modules &&\
	apk add wget git wget unzip which curl tar &&\
	apk add --no-cache bash &&\
	mkdir -p /tmp &&\
	cd /tmp &&\
	git clone https://github.com/yahoo/kafka-manager &&\
	cd /tmp/kafka-manager &&\
	git checkout tags/${KM_VERSION}

RUN cd /tmp/kafka-manager &&\
	echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt &&\
	./sbt clean dist &&\
	unzip -d / ./target/universal/kafka-manager-${KM_VERSION}.zip &&\
	rm -fr /tmp/* /root/.sbt /root/.ivy2

ADD start-kafka-manager.sh /kafka-manager-${KM_VERSION}/start-kafka-manager.sh

RUN touch /kafka-manager-${KM_VERSION}/kafka-manager.pid &&\
	chmod +x /kafka-manager-${KM_VERSION}/start-kafka-manager.sh

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000

ENTRYPOINT ["./start-kafka-manager.sh"]
