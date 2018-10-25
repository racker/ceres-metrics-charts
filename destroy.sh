#!/bin/bash

helm delete data polling hosts ingestion query --purge
kubectl delete ns metrics
