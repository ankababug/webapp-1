FROM centos:7
USER root
COPY /target/WebApp.war .
CMD ["echo","image created"]
