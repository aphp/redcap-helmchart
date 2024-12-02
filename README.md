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
- An `audit` component, that will request the Audit tables of the REDCap Database, and use Logstash to ship them to the audit stack of your choice

The documentation of the Chart can be found in its [README file](./charts/redcap/README.md).

## How can I test it?

In the [example directory](./examples/), there several subdirectories containing documented examples according to your needs. 
- If you want to quicly boot-up a local/test environement, you can start by looking at the [local example](./examples/local/)
- If you want to start deploying a more stable and secure environment, you can have a look at the [production example](./examples/production/)

## General questions

- Is this installation compatible with OIDC/SAML?
  Yes, you can configure OIDC directly in REDCap settings, whilst you'll need to configure and activate SAML2 in the chart's settings [see the chart's documentation](./charts/redcap/README.md). Other authentication methods like LDAP should also work, but haven't been tested properly.
- What REDCap feature can I use?
  This Chart aims to deploy REDCap in an evironment that looks 'familiar' for the application, so you should be able to use any feature you'd use in a more traditional context.
  At the Greater Paris University Hospitals, we use this chart in production for a yeat on several projet. It is possible though that with time, new versions of REDCap will need extra dependencies to be available on the PHP FPM server. If it's the case, the corresponding container image will be released.
- How secure is it?
  With its many parameters, and the exposition of several admin pages like cronjob ot install, this installation will be as secure as its configuration. This chart offers many security feature (containerisation, rootless processes, traffic isolation with network policies), so be sure to check them, and to have a comprehensive view of your installation!
- How can I update it?
  We recommend to setup your REDCap installtion using the default method stated [in the examples](./examples/), that is to provide the chart with your REDCap Community credentials via a Secret. You can then simply use the REDCap "one click update" feature to update your installation via the Control Center. 
- How can I manage backups?
  If you're going with the backup/restore feature of this Chart, every backup will contain the redcap application directory, the edocs directory, and a database dump, so you'll be able to restore everything in one go. You're of course free to use any other method!
- I can't get the REDCap application via the community website because my admins won't whitelist the URL/whatever other reasons!
  You can override the init container in charge of retrieving the REDCap application, and add as many other initContainers you like to build your own retrieval logic. I might take some time to get into the logic, but you can help yourself with the few snippets presents [in the exmaple directory](./examples/snippets/).

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