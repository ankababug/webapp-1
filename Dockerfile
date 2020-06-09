FROM centos:7
USER root
COPY /target/WebApp.war .
EXPOSE 8090
CMD ["java","-jar","WebApp.war"]
