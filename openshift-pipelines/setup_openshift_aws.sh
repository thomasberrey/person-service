#!/bin/bash

read -p "Install the OpenShift Pipelines Operator..."

oc new-project book-tekton

oc delete -f git-clone-task.yml
oc delete -f maven-task.yml
oc delete -f kustomize-task.yaml
oc delete -f build-and-push-image.yaml

oc apply -f builder-pvc.yaml
oc apply -f maven-settings-cm.yaml

oc apply -f git-clone-task.yml
oc apply -f maven-task.yml
oc apply -f kustomize-task.yaml
oc apply -f build-and-push-image.yaml
oc apply -f pipelinerun.yaml

tkn pr logs -f -L
