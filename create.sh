#!/bin/bash

helm install --name data --namespace metrics ./influxdb/

helm install --name lookup --namespace metrics ./redis/

helm install --name influxdbscaler --namespace metrics ./influxdb-scaler/

helm install --name routing --namespace metrics ./tenant-routing-service/

## Upgrade command for routing
# helm upgrade routing --namespace metrics ./tenant-routing-service/

helm install --name raw-ingestion --namespace metrics -f ./ingestion-service/override-raw.yaml  ./ingestion-service/

## Upgrade command for raw-ingestion
# helm upgrade raw-ingestion --namespace metrics -f ./ingestion-service/override-raw.yaml  ./ingestion-service/

helm install --name rollup-ingestion --namespace metrics -f ./ingestion-service/override-rollup.yaml  ./ingestion-service/
## Upgrade command for rollup-ingestion
# helm upgrade rollup-ingestion --namespace metrics -f ./ingestion-service/override-rollup.yaml  ./ingestion-service/

helm install --name query --namespace metrics ./query-service/

helm install --name rollup --namespace metrics ./rollup-service/
## Upgrade command for rollup
# helm upgrade rollup --namespace metrics ./rollup-service/
