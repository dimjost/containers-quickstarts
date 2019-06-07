FROM openshift/jenkins-slave-base-centos7

ARG JAVA_VERSION=oracleJdk10.0.2
ARG MAVEN_VERSION=mvn3.6.1
ARG NODEJS_VERSION=nodejs10.16.0
ARG GIT_REPO=/tmp/tools

LABEL com.redhat.component="jenkins-slave-${JAVA_VERSION}-${MAVEN_VERSION}-${NODEJS_VERSION}" \
      name="openshift3/jenkins-slave-${JAVA_VERSION}-${MAVEN_VERSION}-${NODEJS_VERSION}" \
      version="3.11" \
      architecture="x86_64" \
      release="1" \
      io.k8s.display-name="Jenkins Slave ${JAVA_VERSION}, ${MAVEN_VERSION} and ${NODEJS_VERSION}" \
      io.k8s.description="The jenkins slave ansible image has ansible on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,ansible"

ENV BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable"
    

#################
### Update OS ###
#################
RUN yum -y update



###################
### Install GIT ###
###################
RUN yum install -y git



########################
### Clone Tools-Repo ###
########################
RUN git clone https://github.com/dimjost/tools ${GIT_REPO}
RUN ls -l ${GIT_REPO}






ARG TOOL_DIR=/opt/tools
ARG JAVA_DIR=${TOOL_DIR}/java
ARG MAVEN_DIR=${TOOL_DIR}/maven
ARG NODEJS_DIR=${TOOL_DIR}/nodejs

####################
### Install Java ###
####################
RUN cat ${GIT_REPO}/java/${JAVA_VERSION}* > ${GIT_REPO}/java/${JAVA_VERSION}.tar.gz
RUN ls -l ${GIT_REPO}/java/
RUN mkdir -p ${JAVA_DIR} \
   && cat ${GIT_REPO}/java/${JAVA_VERSION}* > ${GIT_REPO}/java/${JAVA_VERSION}.tar.gz \
   && tar -xzf ${GIT_REPO}/java/${JAVA_VERSION}.tar.gz -C ${JAVA_DIR} --strip-components=1 \
   && && rm -f ${GIT_REPO}/java/${JAVA_VERSION}.tar.gz
ENV PATH="${JAVA_DIR}/bin:${PATH}"
RUN java -version






#######################
### Install OpenJDK ###
#######################
#ADD yum-install.sh /opt/yum-install.sh
#RUN chmod +x /opt/yum-install.sh
#RUN /opt/yum-install.sh

#RUN yum install -y java-11-openjdk-devel.x86_64 && \
#    rpm -V  java-11-openjdk-devel && \
#    yum clean all -y
	
	
#####################
### Install Maven ###
#####################
#RUN mkdir -p $HOME/.m2
#ARG MAVEN_DIR=/opt/maven/apache-maven-${MAVEN_VERSION}
#ARG MAVEN_BASE_URL=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/${MAVEN_VERSION}
#ENV M2_HOME ${MAVEN_DIR}
#ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

#RUN mkdir -p ${MAVEN_DIR} \
#  && curl ${MAVEN_BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz --output /tmp/apache-maven.tar.gz  \
#  && tar -xzf /tmp/apache-maven.tar.gz -C ${MAVEN_DIR} --strip-components=1 \
#  && rm -f /tmp/apache-maven.tar.gz 

#ENV PATH="${MAVEN_DIR}/bin:${PATH}"


###################
### Install NPM ###
###################
#ARG NPM_DIR=${USER_HOME_DIR}/node-v${NPM_VERSION}
#ARG NPM_BASE_URL=https://nodejs.org/dist/v${NPM_VERSION}

#RUN mkdir -p ${NPM_DIR} \
#	&& curl ${NPM_BASE_URL}/node-v${NPM_VERSION}-linux-x64.tar.gz --output /tmp/node-v${NPM_VERSION}-linux-x64.tar.gz \
#	&& tar -xf /tmp/node-v${NPM_VERSION}-linux-x64.tar.gz -C ${NPM_DIR} --strip-components=1 \
#	&& rm -f /tmp/node-v${NPM_VERSION}-linux-x64.tar.gz

#ENV PATH="${NPM_DIR}/bin:${PATH}"
#RUN npm install -g npm-check-updates


#RUN chown -R 1001:0 $HOME && \
#    chmod -R g+rw $HOME
    
#RUN chown -R 1001:0 /opt && \
#    chmod -R g+rw /opt

USER 1001

#CMD ["mvn"]
