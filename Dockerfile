# base
FROM jenkins/inbound-agent:latest

USER root
RUN curl -O https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
    && tar zxvf docker-latest.tgz \
    && cp docker/docker /usr/local/bin/ \
    && rm -rf docker docker-latest.tgz \
    && ln -s /usr/local/openjdk-8/ /usr/local/java \
    && echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

ENTRYPOINT ["jenkins-agent"]
