# Spinnaker Operator Installation

Followed Spinnaker's *Quick Start* section from it's GitHub [README](https://github.com/armory/spinnaker-operator/blob/master/README.md). Only difference is to deploy the operator from the *deploy/operator/basic* directory instead of *deploy/operator/cluster*.

#after argo is deployed, you need to modify the argocd-cm configmap to ignore difference or the spinnaker operator will not sync because of one of the secrets.  See jsonPointers feild below.  For details, see https://argo-cd.readthedocs.io/en/stable/user-guide/diffing/

`kubectl edit cm argocd-cm -n nethopper`

```
apiVersion: v1
data:
  accounts.admin: apiKey, login
  application.resourceTrackingMethod: annotation+label
  resource.customizations.ignoreDifferences.all: |
    managedFieldsManagers:
    - crossplane-aws-provider
    jsonPointers:
    - /data
kind: ConfigMap`
```

`kubectl patch cm spin-deck -n spinnaker --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'`

#Created KAOPS apps for the *crds* and *deploy* folders. Set deploy app namespace to *spinnaker-operator* and enable auto-create namespace when creating the app in KAOPS.

#Then, wait until the apps above are fully deployed (ie green).  

# Spinnaker Installation

#Then Create KAOPS apps for the *spin-deploy* folder.  Set namespace to default, and enable auto-create namespace.

#Then, wait for the 7 pods to fully deploy in the spinnaker namespace.

`kubectl get pods -n spinnaker`

#Then, patch the spin-deck service from ClusterIP to NodePort so that you can connect to the spinnaker UI.

`kubectl patch svc spin-deck -n spinnaker --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"}]'`


**NOTE**: Be sure to check k8s compatibility in Spinnaker's README (link above).

## Testing Notes ##
* Verified v1.3.1 deployed 'Healthy' on EKS K8s 1.25 and 1.28

