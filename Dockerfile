FROM alpine:3.7
RUN addgroup -S tomcat
RUN adduser -S tomcat -G tomcat
ENV CATALINA_HOME /opt/tomcat
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
RUN apk add --no-cache openjdk8-jre=8.151.12-r0 && ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/"
RUN  { set -eux;\
TOMCAT_VERSION=$(wget -q -O - http://www.eu.apache.org/dist/tomcat/tomcat-8/ | grep -E -o "8\.[0\.]+.[0-9]+" | uniq ); \
wget -q http://archive.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz; \
mkdir -p /opt/tomcat; \
tar xf apache-tomcat-$TOMCAT_VERSION.tar.gz -C /opt/tomcat --strip-components=1; \
rm -f apache-tomcat-$TOMCAT_VERSION.tar.gz; \
rm -r /opt/tomcat/webapps/docs; \
rm -r /opt/tomcat/webapps/examples; \
}
COPY tomcat-users.xml /opt/tomcat/conf/
RUN chown -R tomcat:tomcat /opt/tomcat
USER tomcat
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
