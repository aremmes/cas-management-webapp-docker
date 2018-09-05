#!/bin/bash
# Config variables from RC env settings
export JAVA_HOME=/opt/jre-home
export PATH=$PATH:$JAVA_HOME/bin:.
export JVM_OPTS="${JVM_OPTS:=-server -Xms2048m -Xmx2048m -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=512m -XX:MinHeapFreeRatio=35 -XX:MaxHeapFreeRatio=80 -XX:NewRatio=8 -XX:SurvivorRatio=32 -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+UseParNewGC}"
export HOSTNAME=${HOSTNAME:=dev-sso-mgmt.dev.coredial.com}
export REGISTRY_DB_HOST=${REGISTRY_DB_HOST:=localhost}
export REGISTRY_DB_PORT=${REGISTRY_DB_PORT:=3306}
export REGISTRY_DB_NAME=${REGISTRY_DB_NAME:=portalsso}
export REGISTRY_DB_USER=${REGISTRY_DB_USER:=cas}
export REGISTRY_DB_PASS=${REGISTRY_DB_PASS:=c4s1sb3tt3r}
export TOMCAT_KEYSTORE_FILE="${TOMCAT_KEYSTORE_FILE:=file:///etc/cas/ssl/star.dev.coredial.com.p12}"
export TOMCAT_KEYSTORE_TYPE="${TOMCAT_KEYSTORE_TYPE:=PKCS12}"
export TOMCAT_KEYSTORE_PASS="${TOMCAT_KEYSTORE_PASS:=k3y5t0r3}"
export TOMCAT_KEY_PASS="${TOMCAT_KEY_PASS:=k3y5t0r3}"
export TOMCAT_KEY_ALIAS="${TOMCAT_KEY_ALIAS:=1}"
export CAS_SERVER_NAME="${CAS_SERVER_NAME:=}"
export CAS_SERVER_PREFIX="${CAS_SERVER_PREFIX:=}"
export CAS_MGMT_SERVER_NAME="${CAS_MGMT_SERVER_NAME:=https://${HOSTNAME}:8444}"

# Build CAS Management config file
source /cas-management-overlay/bin/write-management-properties.sh

# echo "Use of this image/container constitutes acceptence of the Oracle Binary Code License Agreement for Java SE."
cd /cas-management-overlay/
env |sort
echo -e "Executing build from directory: $(pwd)"
echo -e "Executing command: exec java ${JVM_OPTS} -jar target/cas.war"
exec java ${JVM_OPTS} -jar target/cas-management.war
