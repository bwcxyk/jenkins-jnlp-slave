# base
FROM jenkins/inbound-agent:latest-jdk11

USER root
RUN set -x \
    && apt update \
    && apt install curl wget -y \
    && curl -OL https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
    && tar -zxf docker-latest.tgz \
    && cp docker/docker /usr/local/bin/ \
    && rm -rf docker docker-latest.tgz \
    && curl -OL https://archive.apache.org/dist/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz \
    && tar -zxf apache-maven-3.6.2-bin.tar.gz \
    && mv apache-maven-3.6.2 /usr/local/maven \
    && rm -f apache-maven-3.6.2-bin.tar.gz \
    && curl -OL https://npm.taobao.org/mirrors/node/v12.13.1/node-v12.13.1-linux-x64.tar.gz \
    && tar -zxf node-v12.13.1-linux-x64.tar.gz \
    && mv node-v12.13.1-linux-x64 /usr/local/nodejs \
    && rm -f node-v12.13.1-linux-x64.tar.gz \
    && ln -s /usr/local/openjdk-8/ /usr/local/java \
    && echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

COPY settings.xml /usr/local/maven/conf/

ENV NODE_HOME="/usr/local/nodejs"
ENV MAVEN_HOME="/usr/local/maven"
ENV PATH=${PATH}:${NODE_HOME}/bin:$MAVEN_HOME/bin

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org \
    # 配置npm私有仓库
    && npm config set registry http://192.168.1.200:8081/nexus/repository/npm-group/ \
    && cnpm config set registry http://192.168.1.200:8081/nexus/repository/npm-group/ \
    && git config --global user.email "jenkins@example.com" \
    && git config --global user.name "jenkins" \
    && git config --global credential.helper store

ENTRYPOINT ["jenkins-agent"]
