#!/bin/bash

helm install --name data --namespace metrics ./influxdb/
helm install --name polling --namespace metrics ./telegraf-s/
helm install --name hosts --namespace metrics ./telegraf-ds/
helm install --name lookup --namespace metrics ./redis/
helm install --name routing --namespace metrics ./tenant-routing-service/
helm install --name raw-ingestion --namespace metrics -f ./ingestion-service/override-raw.yaml  ./ingestion-service/
helm install --name rollup-ingestion --namespace metrics -f ./ingestion-service/override-rollup.yaml  ./ingestion-service/
helm install --name query --namespace metrics ./query-service/
helm install --name rollup --namespace metrics ./rollup-service/
