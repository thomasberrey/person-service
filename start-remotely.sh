#!/bin/bash

oc new-project person-service
oc project person-service
oc delete all --all

mvn package -Dquarkus.container-image.push=true

oc new-app --name personserver postgresql-persistent \
-p POSTGRESQL_USER=person \
-p POSTGRESQL_PASSWORD=person \
-p POSTGRESQL_DATABASE=persondb \
-p DATABASE_SERVICE_NAME=personserver

oc delete -f postresql_secret.yaml
oc apply -f postresql_secret.yaml

oc delete -f target/kubernetes/openshift.yml
oc apply -f target/kubernetes/openshift.yml

PERSON_SERVICE_ROUTE=$(oc get route person-service -o template --template '{{ "http://" }}{{ .spec.host }}')
echo PERSON_SERVICE_ROUTE=$PERSON_ROUTE

#http POST $PERSON_SERVICE_ROUTE/person firstName=Jimi lastName=Hendrix salutation=Mr
#http POST $PERSON_SERVICE_ROUTE/person firstName=Joe lastName=Cocker salutation=Mr
#http POST $PERSON_SERVICE_ROUTE/person firstName=Carlos lastName=Santana salutation=Mr

#http $PERSON_SERVICE_ROUTE
