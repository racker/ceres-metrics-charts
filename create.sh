#!/bin/bash
set -e

WHERE_HELM=$(which -a helm | head -1)
if [[ -z $WHERE_HELM ]] ; then
    echo "Please install helm to run this script"
    echo "Linux with snap:"
    echo "  $ sudo snap install helm --classic"
    echo "MacOS with Homebrew"
    echo " brew install kubernetes-helm"
    echo "Other *nix"
    echo " $ wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-amd64.tar.gz && \ "
    echo "    tar -zxvf helm-v2.12.3-linux-amd64.tar.gz && \ "
    echo "    find -executable -type f -name helm -exec sudo cp -v {} /usr/local/bin/ "
    exit 1
fi

# Set namespace to testing by default
if [[ -z "$1" ]] ; then
    NAMESPACE="default"
else
    # Does given namespace exist
    NS_COUNT=$($(which kubectl) get namespace | grep "^${1} " | wc -l)
    if [[ "$NS_COUNT" == '0' ]] ; then
        echo "It appears that the namespace $1 does not exist"
        $(which kubectl) get namespace
    else
        NAMESPACE=$1
    fi
fi

$WHERE_HELM install --name data --namespace $NAMESPACE ./helm-ceres-influxdb/
$WHERE_HELM install --name polling --namespace $NAMESPACE ./helm-ceres-telegraf-s/
$WHERE_HELM install --name hosts --namespace $NAMESPACE ./helm-ceres-telegraf-ds/
$WHERE_HELM install --name lookup --namespace $NAMESPACE ./redis/
$WHERE_HELM install --name routing --namespace $NAMESPACE ./helm-ceres-tenant-routing-service/
$WHERE_HELM install --name raw-ingestion --namespace $NAMESPACE -f ./helm-ceres-ingestion-service/override-raw.yaml  ./helm-ceres-ingestion-service/
$WHERE_HELM install --name rollup-ingestion --namespace $NAMESPACE -f ./helm-ceres-ingestion-service/override-rollup.yaml  ./helm-ceres-ingestion-service/
$WHERE_HELM install --name query --namespace $NAMESPACE ./helm-ceres-query-service/
$WHERE_HELM install --name rollup --namespace $NAMESPACE ./helm-ceres-rollup-service/

echo "Good Luck and may the force be with you!!!"
