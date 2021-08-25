#!/bin/bash
oc project mq 
set +e
# Remove the runnning queue manager instance (if any)

oc delete QueueManager mqcl3

# Delete the route object and secret for the QueueManager keystore (if any), and the mqsc configMap
oc delete route mqcl3route
oc delete secret mqcl3key
oc delete configMap cl3-mqsc
set -e
# Create the route and the keystore secret and mqsc configMap
oc apply -f mqcl3Route.yaml
oc create secret tls mqcl3key --cert=./tls/tls.crt --key=./tls/tls.key
oc create -f mqsc/mqsc.yaml

set -e
oc apply -f mqDeploy.yaml
