# base
FROM jenkins/inbound-agent:latest

USER root
RUN curl -O https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
    && tar zxvf docker-latest.tgz \
    && cp docker/docker /usr/local/bin/ \
    && rm -rf docker docker-latest.tgz \
    && wget https://archive.apache.org/dist/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz \
    && tar zxvf apache-maven-3.6.2-bin.tar.gz \
    && mv apache-maven-3.6.2 /usr/local/maven \
    && rm -f apache-maven-3.6.2-bin.tar.gz \
    && wget https://npm.taobao.org/mirrors/node/v12.13.1/node-v12.13.1-linux-x64.tar.xz \
    && tar xf node-v12.13.1-linux-x64.tar.xz \
    && mv node-v12.13.1-linux-x64 /usr/local/nodejs \
    && rm -f node-v12.13.1-linux-x64.tar.xz \
    && ln -s /usr/local/openjdk-8/ /usr/local/java \
    && echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

COPY settings.xml /usr/local/maven/conf/

ENV NODE_HOME="/usr/local/nodejs"
ENV MAVEN_HOME="/usr/local/maven"
ENV PATH=${PATH}:${NODE_HOME}/bin:$MAVEN_HOME/bin

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org \
    && git config --global user.email "jenkins@example.com" \
    && git config --global user.name "jenkins" \
    && git config --global credential.helper store

ENTRYPOINT ["jenkins-agent"]
