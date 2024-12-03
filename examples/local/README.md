# Local Installation

If you wish to quickly fire a REDCap installation with this chart, you may follow the following steps.

**WARNING** : This installation is meant to be local-only or for test purposes, and is ni way stable, scalable and secure enough to host actual data and provide a service to end users!

## Prerequisites
You must first ave a ready-to-use Kubernetes cluster on which you can deploy REDCap. You can quickly deploy one locally, or on a VM using KinD:

- Install KinD by following [the dedicated documentation](https://kind.sigs.k8s.io/docs/user/quick-start#installation)
- Setup a KinD Cluster with Ingress capabilities by following [the dedicated documentation](https://kind.sigs.k8s.io/docs/user/ingress/)
- Install kubectl to operate your KinD cluster by following [the dedicated documentation](https://kubernetes.io/fr/docs/tasks/tools/install-kubectl)
- Install Helm to manage Helm Charts by following [the dedicated documentation](https://helm.sh/docs/intro/install/)

## Installation
To install REDCap, follow those steps :

- Create the namespace that will contain the REDCap installation : 
  ```
  kubectl create namespace redcap
  ```
- Create a secret holding your REDCap Community Site credentials :
  ```sh
  kubectl -n redcap create secret generic redcap-community-credentials --from-literal USERNAME='my-username' --from-literal PASSWORD='my-password'
  ```
- Add this Helm Repository to your Helm installation : 
  ```sh
  helm repo add aphp-redcap https://aphp.github.io/redcap-helmchart
  ```
- Update your Helm repositories :
  ```sh
  helm repo update
  ```
- Install this chart using this values file : 
  ```sh
  helm upgrade --install -n redcap redcap aphp-redcap/redcap -f ./examples/local/values.yaml --wait
  ```

## Post-installation
You can access the installation by accessing http://localhost:80.

Make sure to take the following actions : 
- In `Control Center` -> `General Configuration` -> REDCap base URL, set the field to `http://localhost/`
- In `Control Center` -> `File Upload Settings` -> `Local Server File Storage`, set the fiels to `/edocs`, which is the mapping of the `edocs` dir in this REDCap installation.