#!/bin/bash

helm delete data polling hosts raw-ingestion rollup-ingestion query lookup routing rollup --purge
#kubectl delete ns metrics
