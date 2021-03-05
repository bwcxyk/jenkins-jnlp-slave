

使用方法

```bash
docker run -d \
-e JENKINS_URL=http://192.168.1.10/jenkins
-e JENKINS_SECRET=xxxxxxxxxxxxxxxx
-e JENKINS_AGENT_WORKDIR=/home/jenkins/agent
-e JENKINS_AGENT_NAME=slave1
-v /var/run/docker.sock:/var/run/docker.sock
yaokun/jenkins-jnlp:latest
```

