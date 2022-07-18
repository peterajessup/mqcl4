#!/bin/bash
oc project mq 
set +e
# Remove the runnning queue manager instance (if any)

oc delete QueueManager mqcl4

# Delete the route object and secret for the QueueManager keystore (if any), and the mqsc configMap
oc delete route mqcl4route
oc delete secret mqcl4key
oc delete configMap cl4-mqsc
set -e
# Create the route and the keystore secret and mqsc configMap
oc apply -f mqcl4Route.yaml
oc create secret tls mqcl4key --cert=./tls/tls.crt --key=./tls/tls.key
oc create -f mqsc/mqsc.yaml

set -e
oc apply -f mqDeploy.yaml
