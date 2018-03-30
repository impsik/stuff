FROM alpine:3.7
ENV LANG C.UTF-8
# Comment in next line if you want specific version. By default it detects and takes latest 8.0.x version
#ENV TOMCAT_VERSION 8.0.47
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV JAVA_VERSION 8
ENV JAVA_ALPINE_VERSION 8.151.12-r0
RUN apk add --no-cache openjdk8-jre="$JAVA_ALPINE_VERSION"
RUN  { set -eux;\
# Comment out next line if you want specific version
TOMCAT_VERSION=$(wget -q -O - http://www.eu.apache.org/dist/tomcat/tomcat-8/ | grep -E -o "8\.[0\.]+.[0-9]+" | uniq ); \
wget -q http://archive.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz; \
mkdir -p /opt/tomcat; \
tar xf apache-tomcat-$TOMCAT_VERSION.tar.gz -C /opt/tomcat --strip-components=1; \
rm -f apache-tomcat-$TOMCAT_VERSION.tar.gz; \
}
EXPOSE 8080
CMD ["catalina.sh", "run"]