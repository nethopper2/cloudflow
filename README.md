 # README
This repository contains application source code and IaC modules for a fictional company called *Cloudflow*.

The intended use for this repo is the demonstrate the ability of the Nethopper KAOps platform to build
and deploy customer applications and infrastructure.

## Directories
There are three directories (*app*, *iac*, *manifests*)intended to demonstrate a customers repository of application
source code (**app**), manifest files for those applications (**manifests**), and Infrastructure-as-Code (IaC)
manifests (**iac/crossplane**) and/or HCL Terraform modules (**iac/tf**).

## Apps and Manifests
The following table describes applications and their associated manifests contained in this repo.

| APPLICATION | DESCRIPTION| MANIFEST/S |
| :--- | :--- | :--- |
| apps/demoapp | Node program that builds the frontend and backend applications  | manifests/demoapp/{frontend,backend} |

## IaC ##
The **iac** directory contains projects to testing and demonstrating the Nethopper's PaaS' ability to create
infrastructure using Crossplane, Crossplane's Terraform (TF) provider, and ArgoCD.

The following table describes the IaC directories.
| DIRECTORY | DESCRIPTION|
| :--- | :--- |
| iac/crossplane | Existing customer Crossplane manifests |
| iac/tf | Existing customer Terraform modules (used by Crossplane projects) |

### Crossplane Terraform Projects ###
A Crossplane TF project is a resource created by Crossplane's TF provider and managed in a declaritive manner
by ArgoCD. 

Each project has two directories. One directory contains TF modules (HCL) and the other a Crossplane workspace.
The workspace directory is used by Crossplane to instantiate the infra created by the associated modules directory.

The modules directory can be considered existing customer TF. Those modules will be found in this repo under the
*tf* directory (e.g. eks-aws). The associated workspace directory will be found in the *kaops* repo in an IaC
sub-directory of the same name.

The following table the IaC TF modules contained in this repo.

| DIRECTORY | DESCRIPTION | KAOPS (repo) WORKSPACE |
| :--- | :--- | :--- |
| eks-aws | TF modules required to build an EKS cluster in AWS | kaops/iac/xplane/tf-workspace/eks-aws |
| vpc-aws | TF modules required to create a VPC in AWS | kaops/iac/xplane/tf-workspace/vpc-aws |


<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test -->
<!-- test for chris -->
<!-- test for chris2 -->
<!-- test for chris3 -->
<!-- test for chris4 -->
<!-- test for chris5 -->
<!-- test for chris6 -->
<!-- test for chris7 -->
<!-- test for chris8 -->
<!-- test for chris9 -->
<!-- test for chris10 -->
<!-- test for chris11 -->
<!-- test for chris12 -->
<!-- test for chris13 -->
