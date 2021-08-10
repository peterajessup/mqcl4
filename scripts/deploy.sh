#!/bin/bash
oc project ibmmq 
set +e
# Remove the runnning queue manager instance (if any)

oc delete QueueManager mqcl1

# Delete the route object and secret for the QueueManager keystore (if any), and the mqsc configMap
oc delete route mqcl1route
oc delete secret mqcl1key
oc delete configMap cl1-mqsc
set -e
# Create the route and the keystore secret and mqsc configMap
oc apply -f mqcl1Route.yaml
oc create secret tls mqcl1key --cert=./tls/tls.crt --key=./tls/tls.key
oc create -f mqsc/mqsc.yaml

set -e
oc apply -f mqDeploy.yaml
