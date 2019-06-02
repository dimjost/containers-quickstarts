FROM openshift/jenkins-slave-base-centos7

LABEL com.redhat.component="jenkins-slave-mvn3.6.1-openJDK11-nodeJs10.15.3" \
      name="openshift3/jenkins-slave-mvn3.6-openjdk11-node10" \
      version="3.11" \
      architecture="x86_64" \
      release="1" \
      io.k8s.display-name="Jenkins Slave Maven-3.6 and openJDK-11" \
      io.k8s.description="The jenkins slave ansible image has ansible on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,ansible"

ENV MAVEN_VERSION=3.6.1 \
	NPM_VERSION=10.15.3 \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable"
    

#################
### Update OS ###
#################
RUN yum -y update



###########################
### Remove old Java JDK ###
###########################
# RUN yum -y remove $(rpm -qa | grep openjdk)



#######################
### Install OpenJDK ###
#######################
ADD yum-install.sh /opt/yum-install.sh
RUN chmod +x /opt/yum-install.sh
RUN /opt/yum-install.sh

#RUN yum install -y java-11-openjdk-devel.x86_64 && \
#    rpm -V  java-11-openjdk-devel && \
#    yum clean all -y
	
	
#####################
### Install Maven ###
#####################
RUN mkdir -p $HOME/.m2
ARG MAVEN_DIR=${USER_HOME_DIR}/apache-maven-${MAVEN_VERSION}
ARG MAVEN_BASE_URL=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/${MAVEN_VERSION}
ENV M2_HOME ${MAVEN_DIR}
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

RUN mkdir -p ${MAVEN_DIR} \
  && curl ${MAVEN_BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz --output /tmp/apache-maven.tar.gz  \
  && tar -xzf /tmp/apache-maven.tar.gz -C ${MAVEN_DIR} --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz 

ENV PATH="${MAVEN_DIR}/bin:${PATH}"


###################
### Install NPM ###
###################
ARG NPM_DIR=${USER_HOME_DIR}/node-v${NPM_VERSION}
ARG NPM_BASE_URL=https://nodejs.org/dist/v${NPM_VERSION}

RUN mkdir -p ${NPM_DIR} \
	&& curl ${NPM_BASE_URL}/node-v${NPM_VERSION}-linux-x64.tar.gz --output /tmp/node-v${NPM_VERSION}-linux-x64.tar.gz \
	&& tar -xf /tmp/node-v${NPM_VERSION}-linux-x64.tar.gz -C ${NPM_DIR} --strip-components=1 \
	&& rm -f /tmp/node-v${NPM_VERSION}-linux-x64.tar.gz

ENV PATH="${NPM_DIR}/bin:${PATH}"
RUN npm install -g npm-check-updates


RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001

CMD ["mvn"]
