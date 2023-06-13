#!/bin/bash
cd /home/sbasu/opentelmetry

mvn clean package -Dmaven.test.skip=true

AGENT_FILE=opentelemetry-javaagent-all.jar
if [ ! -f "${AGENT_FILE}" ]; then
    curl -L https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v1.26.0/opentelemetry-javaagent.jar --output ${AGENT_FILE}
fi

export OTEL_TRACES_EXPORTER=otlp
export OTEL_METRICS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_ENDPOINT=http://192.168.25.129:5555
export OTEL_RESOURCE_ATTRIBUTES=service.name=hello-app,service.version=1.0

java -javaagent:./${AGENT_FILE} -jar /home/sbasu/opentelmetry/target/hello-app-1.0.jar