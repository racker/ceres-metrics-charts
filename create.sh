#!/bin/bash

helm install --name data --namespace metrics ./influxdb/
helm install --name polling --namespace metrics ./telegraf-s/
helm install --name hosts --namespace metrics ./telegraf-ds/
helm install --name queryservice --namespace metrics ./query-service/
