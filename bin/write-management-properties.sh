#!/bin/bash

# Build CAS Management config file
cat > /etc/cas/config/management.properties <<_EOF_
##
# CAS Thymeleaf Views
#
spring.thymeleaf.cache=false
spring.thymeleaf.mode=HTML
spring.thymeleaf.order=1

##
# Embedded CAS Tomcat Container
#
server.context-path=/cas-management
server.port=8444
server.ssl.key-store=file:///etc/cas/ssl/${TOMCAT_KEYSTORE_FILE}
server.ssl.key-store-password=${TOMCAT_KEYSTORE_PASS}
server.ssl.key-password=${TOMCAT_KEY_PASS}
server.ssl.key-alias=${TOMCAT_KEY_ALIAS}
server.ssl.key-store-type=${TOMCAT_KEYSTORE_TYPE}

##
# Log4J Configuration
#
server.context-parameters.isLog4jAutoInitializationDisabled=true
# logging.config=file:/etc/cas/log4j2.xml

##
# CAS
#
cas.server.name=${CAS_SERVER_NAME}
cas.server.prefix=${CAS_SERVER_PREFIX}

cas.mgmt.serverName=${CAS_MGMT_SERVER_NAME}

##
# CAS Authentication Attributes
#
cas.authn.attributeRepository.stub.attributes.uid=uid
cas.authn.attributeRepository.stub.attributes.givenName=givenName
cas.authn.attributeRepository.stub.attributes.eppn=eppn

##
# CAS Web Application Config
#
server.session.timeout=1800
server.session.cookie.http-only=true
server.session.tracking-modes=COOKIE

##
# CAS Cloud Bus Configuration
# Please leave spring.cloud.bus.enabled set to false
#
spring.cloud.bus.enabled=false
# The configuration directory where CAS should monitor to locate settings.
spring.cloud.config.server.native.searchLocations=file:///etc/cas/config

##
# Actuator Endpoint Security Defaults
#
endpoints.sensitive=true
endpoints.enabled=false
endpoints.actuator.enabled=false

##
# CAS JPA Service Registry Configuration
#
cas.serviceRegistry.jpa.healthQuery=select 1+1 two
# cas.serviceRegistry.jpa.isolateInternalQueries=false
cas.serviceRegistry.jpa.url=jdbc:mysql://${REGISTRY_DB_HOST}:${REGISTRY_DB_PORT}/${REGISTRY_DB_NAME}?useUnicode=true&characterEncoding=UTF-8&useFastDateParsing=false&useSSL=false
# cas.serviceRegistry.jpa.failFastTimeout=1
cas.serviceRegistry.jpa.dialect=org.hibernate.dialect.MySQL5InnoDBDialect
# cas.serviceRegistry.jpa.leakThreshold=10
# cas.serviceRegistry.jpa.batchSize=1
cas.serviceRegistry.jpa.user=${REGISTRY_DB_USER}
cas.serviceRegistry.jpa.ddlAuto=update
cas.serviceRegistry.jpa.password=${REGISTRY_DB_PASS}
# cas.serviceRegistry.jpa.autocommit=false
cas.serviceRegistry.jpa.driverClass=com.mysql.jdbc.Driver
# cas.serviceRegistry.jpa.idleTimeout=5000
# cas.serviceRegistry.jpa.dataSourceName=java:/comp/env/jdbc/CasDatabase
# cas.serviceRegistry.jpa.dataSourceProxy=false
# Hibernate-specific properties (i.e. 'hibernate.globally_quoted_identifiers')
# cas.serviceRegistry.jpa.properties.propertyName=propertyValue
_EOF_
