#!/bin/bash

helm delete data polling hosts queryservice --purge
kubectl delete ns metrics
