FROM tomcat:latest
RUN rm -rf /usr/local/tomcat/webapps/ROOT
COPY target/onlinebookstore.war /usr/local/tomcat/webapps/onlinebookstore.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
