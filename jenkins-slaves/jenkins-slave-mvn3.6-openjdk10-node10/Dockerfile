FROM openshift/jenkins-slave-base-centos7:v3.11

LABEL com.redhat.component="jenkins-slave-ansible-rhel7-docker" \
      name="openshift3/jenkins-slave-mvn3.6-openjdk10-node10" \
      version="3.11" \
      architecture="x86_64" \
      release="1" \
      io.k8s.display-name="Jenkins Slave Maven-3.6 and openJDK-10" \
      io.k8s.description="The jenkins slave ansible image has ansible on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,ansible"

ENV MAVEN_VERSION=3.6 \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable"

# Install Maven
RUN INSTALL_PKGS="java-10-openjdk-devel.x86_64 rh-maven36*" && \
    yum install -y $INSTALL_PKGS && \
    rpm -V  java-10-openjdk-devel rh-maven36 && \
    yum clean all -y && \
	mkdir -p $HOME/.m2


RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
