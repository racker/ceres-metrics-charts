#!/bin/bash

helm delete data polling hosts ingestion query lookup routing rollup --purge
#kubectl delete ns metrics
