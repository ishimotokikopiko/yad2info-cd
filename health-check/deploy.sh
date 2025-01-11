#!/bin/bash
set -e

# Set defaults.
CHART_NAME="health-check"
K8S_NS="dev"
TEMPLATE="false"
TIME_OUT="300s"
VALUES_FILE="./values.yaml"

# Debug print.
echo "###################################" 
echo "CHART_NAME=${CHART_NAME}"
echo "K8S_NS=${K8S_NS}"
echo "TEMPLATE=${TEMPLATE}"
echo "TIME_OUT=${TIME_OUT}"
echo "VALUES_FILE=${VALUES_FILE}"
echo "###################################" 

# helm template and deploy.
echo "###################################" 
echo "####### Helm Template #######"
echo "###################################" 
helm template ${CHART_NAME} ./ --namespace ${K8S_NS} --output-dir render_temp -f ${VALUES_FILE} --debug

echo "###################################" 
echo "####### Helm Deploy #######"
echo "###################################" 
helm upgrade --install ${CHART_NAME} ./ \
  --namespace ${K8S_NS} --create-namespace \
  --create-namespace -f ${VALUES_FILE} \
  --wait --timeout ${TIME_OUT}