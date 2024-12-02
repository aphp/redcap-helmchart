# `aphp/redcap-helmchart`

## Presentation
This repository hosts the REDCap Helm Chart developped by the Greater Paris University Hospitals (`APHP` in French - Assistance Publique des Hôpitaux de Paris). This Chart allows for a cloud-natuve and cloud-agnostic deployment of REDCap, a secure web application for building and managing online surveys and databases.

REDCap is devopped by the Vanderbilt University and **is not provided by this Chart or any of its dependencies.**
If you wish to use REDCap and are not sure where to start, you may visit the dedicated [REDCap Community Site](https://projectredcap.org/resources/community/).

This Chart aims to provide with an easy way to retrieve the REDcap application from the official server (using your consortium member's credentials), and deploying it in a standard Kubernetes encluster, be it on-premise or in a managed cloud environement.

## How does it works?

The architecture of the REDCap stack deployed by this Chart is as follows :

![REDCap Architecture](./resources/redcap-arch.svg)

A minimal setup of ths stack includes : 
- The HTTPd component
- The PHP FPM Server hosting the REDCap Application
- The MySQL Database used by REDCap
- The Administration Cronjob, in charge of launching REDCap's cronjobs hourly.

On top of that, you can also choose to deploy : 
- A Backup Cronjob, that can generate an archive containing a database dump, a dump of the `edocs` folder, and a dump of the folder hosting the REDCap Application.
  This backup is then sended to an S3-compatible storage.
- A Restore Job that can be triggered to restore a previous backup
- An `audit` component, that will request the Audit tables of the REDCap Databasen and use Logstash to ship them to the audit stack of your choice

A few examples of configuration can be found in the [examples](./examples/) folder, and the documentation of the Chart can be found in its [README file](./charts/redcap/README.md).

## How can I test it?

If you wish to quickly fire a REDCap installation with this chart, you may follow the following steps : 

- Have a ready-to-use Kubernetes cluster on which you can deploy REDCap. You can quicly deploy one locally, or on a VM [using KinD with Ingress](https://kind.sigs.k8s.io/docs/user/ingress/).

- Create a secret holding your REDCap Community Site credentials :
  ```sh
  kubectl create secret generic redcap-community-credentials --from-literal USERNAME=my-username --from-literal PASSWORD=my-password
  ```
- Edit the line 04 of the [basic-install file](./examples/basic-install.yaml) to enter the hostname you wish to use for your ingress.
- Add this Helm Repository to your Helm installation : 
  ```sh
  helm repo add aphp-redcap https://aphp.github.io/redcap-helmchart
  ```
- Update your Helm repositories :
  ```sh
  helm repo update
  ```
- Install this chart using the modified values file : 
  ```sh
  helm install redcap aphp-redcap/redcap -f ./examples/basic-install.yaml
  ```


## Continous Integration / Continous Delivery

This project contains a Github Workflow, which will :
- Lint the Chart unsing `helm ct`
- Verify the generated Kubernetes resources using `Kubeconform`
- Scan the Chart for anti-patterns and securoty issues using `Polaris`  
- Validates the Chart deployment on `KinD` using `helm ct`
- Package en release the chart on Hithub using `helm-cr`

## How can I contribute?

You're welcome to read the [contribution guidelines](./CONTRIBUTING.md).

## How is this project licensed?

The informations about the licensing and the dependencies of this project can be found under : 
- The [project's license file](./LICENSE)
- The [legal notice](./NOTICE)