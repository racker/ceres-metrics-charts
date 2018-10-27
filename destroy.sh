#!/bin/bash

helm delete data polling hosts ingestion query routing --purge
kubectl delete ns metrics
