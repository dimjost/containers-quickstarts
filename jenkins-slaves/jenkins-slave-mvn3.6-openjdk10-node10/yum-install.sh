#!/bin/sh

yumInstallPackageName="java-11-openjdk-devel.x86_64"
yumInstallPath="/usr/lib/jvm/java-11-openjdk-11.0.3.7-0.el7_6.x86_64"
rpmVerifyInstalledPackage="java-11-openjdk-devel"
javaHome="/opt/java/java-11-openjdk"


mkdir -p /opt/java


yum install -y ${yumInstallPackageName} && \
    rpm -V ${rpmVerifyInstalledPackage}

ln -s ${yumInstallPath} ${javaHome}


yum clean all -y

