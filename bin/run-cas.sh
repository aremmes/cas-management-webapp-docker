#!/bin/bash
# Config variables from RC env settings
export JAVA_HOME=/opt/jre-home
export PATH=$PATH:$JAVA_HOME/bin:.
export JVM_OPTS="${JVM_OPTS:=-server -Xms2048m -Xmx2048m -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=512m -XX:MinHeapFreeRatio=35 -XX:MaxHeapFreeRatio=80 -XX:NewRatio=8 -XX:SurvivorRatio=32 -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+UseParNewGC}"

# Parameters going into CAS config
declare -A cas_opts
cas_opts=( \
    ["cdllc.hostname"]="${HOSTNAME:=dev-sso.dev.coredial.com}" \
    ["cdllc.registry.db.host"]="${REGISTRY_DB_HOST:=localhost}" \
    ["cdllc.registry.db.port"]="${REGISTRY_DB_PORT:=3306}" \
    ["cdllc.registry.db.name"]="${REGISTRY_DB_NAME:=portalsso}" \
    ["cdllc.registry.db.user"]="${REGISTRY_DB_USER:=cas}" \
    ["cdllc.registry.db.pass"]="${REGISTRY_DB_PASS:=c4s1sb3tt3r}" \
    ["cdllc.tomcat.keystore.file"]="${TOMCAT_KEYSTORE_FILE:=file:///etc/cas/ssl/star.dev.coredial.com.p12}" \
    ["cdllc.tomcat.keystore.type"]="${TOMCAT_KEYSTORE_TYPE:=PKCS12}" \
    ["cdllc.tomcat.keystore.pass"]="${TOMCAT_KEYSTORE_PASS:=k3y5t0r3}" \
    ["cdllc.tomcat.key.pass"]="${TOMCAT_KEY_PASS:=k3y5t0r3}" \
    ["cdllc.tomcat.key.alias"]="${TOMCAT_KEY_ALIAS:=1}" \
    ["cdllc.cas.server.name"]="${CAS_SERVER_NAME}"
    ["cdllc.cas.server.prefix"]="${CAS_SERVER_PREFIX}"
    ["cdllc.cas.mgmt.server.name"]="${CAS_MGMT_SERVER_NAME:=https://${HOSTNAME}:8444}"
)

# Build CAS config parameters
CAS_OPTS=""
for k in ${!cas_opts[@]}; do
    CAS_OPTS+="-D${k}=${cas_opts[${k}]} "
done

# echo "Use of this image/container constitutes acceptence of the Oracle Binary Code License Agreement for Java SE."
cd /cas-management-overlay/
env |sort
echo -e "Executing build from directory: $(pwd)"
echo -e "Executing command: exec java ${JVM_OPTS} ${CAS_OPTS} -jar target/cas.war"
exec java ${JVM_OPTS} ${CAS_OPTS} -jar target/cas-management.war
