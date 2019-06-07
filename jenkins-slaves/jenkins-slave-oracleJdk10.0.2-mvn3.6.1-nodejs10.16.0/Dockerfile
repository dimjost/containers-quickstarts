FROM openshift/jenkins-slave-base-centos7

ARG JAVA_VERSION=oracleJdk10.0.2
ARG MAVEN_VERSION=mvn3.6.1
ARG NODEJS_VERSION=nodejs10.16.0

ARG GIT_REPO=/tmp/tools
ARG TOOL_DIR=/opt/tools
ARG JAVA_DIR=${TOOL_DIR}/java
ARG MAVEN_DIR=${TOOL_DIR}/maven
ARG NODEJS_DIR=${TOOL_DIR}/nodejs

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
RUN yum install -y git && \
	yum clean all -y



########################
### Clone Tools-Repo ###
########################
RUN git clone https://github.com/dimjost/tools ${GIT_REPO}



####################
### Install Java ###
####################
RUN mkdir -p ${JAVA_DIR} && \
	cat ${GIT_REPO}/java/${JAVA_VERSION}* > ${GIT_REPO}/java/${JAVA_VERSION}.tar.gz && \
	tar -xzf ${GIT_REPO}/java/${JAVA_VERSION}.tar.gz -C ${JAVA_DIR} --strip-components=1 && \
	rm -f ${GIT_REPO}/java/${JAVA_VERSION}.tar.gz
ENV PATH="${JAVA_DIR}/bin:${PATH}"



#####################
### Install Maven ###
#####################
RUN mkdir -p ${MAVEN_DIR} && \
	tar -xzf ${GIT_REPO}/maven/${MAVEN_VERSION}.tar.gz -C ${MAVEN_DIR} --strip-components=1
ENV PATH="${MAVEN_DIR}/bin:${PATH}"
ENV M2_HOME ${MAVEN_DIR}
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"


######################
### Install NodeJS ###
######################
RUN mkdir -p ${NODEJS_DIR} && \
	tar -xf ${GIT_REPO}/nodejs/${NODEJS_VERSION}.tar.xz -C ${NODEJS_DIR} --strip-components=1
ENV PATH="${NODEJS_DIR}/bin:${PATH}"
RUN npm install -g npm-check-updates



######################
### Check versions ###
######################
RUN java -version && \
	mvn --version && \
	node --version && \
	npm --version
	
	

######################
### Remove Git-Repo ###
######################
RUN rm -f ${GIT_REPO}



##############################
### Set folder permissions ###
##############################
RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME
    
RUN chown -R 1001:0 /opt && \
    chmod -R g+rw /opt



############################
### Change to build user ###
############################
USER 1001



CMD ["mvn"]
