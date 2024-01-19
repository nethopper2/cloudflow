# Spinnaker Operator Installation

Followed Spinnaker's *Quick Start* section from it's GitHub [README](https://github.com/armory/spinnaker-operator/blob/master/README.md). Only difference is to deploy the operator from the *deploy/operator/basic* directory instead of *deploy/operator/cluster*.

Created KAOPS apps for the *crds* and *deploy* folders. Set deploy app namespace to *spinnaker-operator* and enable auto-create namespace when creating the app in KAOPS.

**NOTE**: Be sure to check k8s compatibility in Spinnaker's README (link above).

## Testing Notes ##
* Verified v1.3.1 deployed 'Healthy' on EKS K8s 1.25 and 1.28

