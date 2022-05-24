#!/bin/bash

crc delete
crc start

read -p "Install the OpenShift Pipelines Operator..."

oc new-project book-tekton

oc apply -f builder-pvc.yaml
oc apply -f maven-settings-cm.yaml

oc apply -f kustomize-task.yaml
oc apply -f build-and-push-image.yaml
oc apply -f pipelinerun.yaml

tkn pr logs -f -L
