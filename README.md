# `aphp/redcap-helmchart`

## Presentation

This repository hosts the REDCap Helm Chart developed by the Greater Paris University Hospitals (`APHP` in French - Assistance Publique des Hôpitaux de Paris). This Chart allows for a cloud-native and cloud-agnostic deployment of REDCap, a secure web application for building and managing online surveys and databases.

REDCap is developed by the Vanderbilt University and **is not provided by this Chart or any of its dependencies.**
If you wish to use REDCap and are not sure where to start, you may visit the dedicated [REDCap Community Site](https://projectredcap.org/resources/community/).

This Chart aims to provide with an easy way to retrieve the REDcap application from the official server (using your consortium member's credentials), and deploying it in a standard Kubernetes cluster, be it on-premise or in a managed cloud environment.

## How does it works?

The architecture of the REDCap stack deployed by this Chart is as follows :

![REDCap Architecture](./resources/redcap-arch.svg)

A minimal setup of this stack includes : 
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
- If you want to quickly boot-up a local/test environment, you can start by looking at the [local example](./examples/local/)
- If you want to start deploying a more stable and secure environment, you can have a look at the [production example](./examples/production/)

## Lifecycle management

Here are a few important notions to keep in mind to efficiently manage a REDCap installation on a day-to-day basis.

### Init Job

If you choose to automatically install REDCap using your community credentials with this chart, an Kubernetes Job called `init-job` will be automatically fired during the chart's installation process, in order to call the `/install.php` script, with the `auto=1` parameter. This is a convenience script allowing a fresh REDCap installation to be readily available once the chart is installed.

**Note** : The auto-install feature doesn't fully configure the REDCap installation, hence you'll need to do those post-installation actions in the REDCap Control Center as soon as possible : 
- Set the `REDCap base URL`
- Set the `Local Server File Storage` path to `/edocs`
- Set an authentication method
- Checks that the CronJobs were called (you can manually launch one if the Kubernetes CronJob dedicated to this task hasn't run yet)
- Launch the `Configuration Check`

### Administration Cronjob

REDCap needs its `/cronjob.php` script to be called once an hour, in order to run diverse maintenance tasks. A dedicated Kubernetes CronJob has been created to this end, called `admin-cronjob`. It runs by default every hour, using the following schedule : `0 * * * *` . You can modify this scheduling pattern in the chart's parameters (see the [chart's documentation](./charts/redcap/README.md)).

If, for any reasons, you need to manually fire a instance of this CronJob, you can juste use `kubectl` to create spawn a job manually using this command :

```sh
kubectl -n redcap create job manual-admin-job --from cronjob/redcap-admin-job
```

The name of your namespace as well as the name of the jobs may vary depending your installation's configuration and the name you gave to your Helm release.

### Backup Cronjob

This chart allows to backup your REDCap installation automatically. The backup process creates and uploads on an S3 bucket an archive containing the following elements :
- A dump of the `edocs` dir, which contains user-uploaded data
- A dump of the  `redcap` directory, which contains the application
- A dump of the database

A dedicated Kubernetes CronJob has been created to this end, called `backup-cronjob`. It runs by default every 8 hours, using the following schedule : `0 */8 * * *`. You can modify this scheduling pattern in the chart's parameters (see the [chart's documentation](./charts/redcap/README.md)).


You'll need to enable and configure the CronJob in the chart's parameters in order to use it.

If, for any reasons, you need to manually fire a instance of this CronJob, you can juste use `kubectl` to create spawn a job manually using this command :

```sh
kubectl -n redcap create job manual-backup-job --from cronjob/redcap-backup-job
```

The name of your namespace as well as the name of the jobs may vary depending your installation's configuration and the name you gave to your Helm release.

**Note** : The backup process has not been validated by the maintainers of REDCap. Now that this chart is wildly available, we would be glad to work with them to enhance this process. Until then, keep in mind that this process is not official and may contains flaws or limitations, although it has been battle-tested on our end several times.

### Restoration Job

With the backup process, a restoration job has also been set up. It does the reverse of the backup job, and retrieves the backup archive to :
- Restores the `edocs` dir, which contains user-uploaded data
- Restores the  `redcap` directory, which contains the application
- Restores the database dump

In order to have a job template ready to be fired on-demand, a dedicated Kubernetes CronJob has been created to this end, called `restore-cronjob`. It never runs (you wouldn't want to have your data periodically erased by a restore process ;)), but it allows to run a restore process from the latest backup at any time, just with the `kubectl` command : 

```sh
kubectl -n redcap create job manual-restore-job --from cronjob/redcap-restore-job
```

The name of your namespace as well as the name of the jobs may vary depending your installation's configuration and the name you gave to your Helm release.

You'll need to enable and configure the CronJob in the chart's parameters in order to use it (see the [chart's documentation](./charts/redcap/README.md)).

**Note** : The restore process has not been validated by the maintainers of REDCap. Now that this chart is wildly available, we would be glad to work with them to enhance this process. Until then, kepe in mind that this process is not official and may contains flaws or limitations, although it has been battle-tested on our end several times.

## General questions

- *Is this installation compatible with OIDC/SAML?*

  Yes, you can configure OIDC directly in REDCap settings, whilst you'll need to configure and activate SAML2 in the chart's settings [see the chart's documentation](./charts/redcap/README.md). Other authentication methods like LDAP should also work, but haven't been tested properly.

- *What REDCap feature can I use?*

  This Chart aims to deploy REDCap in an environment that looks 'familiar' for the application, so you should be able to use any feature you'd use in a more traditional context.
  At the Greater Paris University Hospitals, we're using this chart in production for more than a year on several projects. It is possible though that with time, new versions of REDCap will need extra dependencies to be available on the PHP FPM server. If it's the case, the corresponding container image will be released.

- *How secure is it?*

  With its many parameters, and the exposition of several admin pages like cronjob or install, this installation will be as secure as its configuration. This chart offers many security feature (containerisation, rootless processes, traffic isolation with network policies, etc.), so be sure to check them, and to have a comprehensive view of your installation!

- *How can I update it?*

  We recommend to setup your REDCap installation using the default method stated [in the examples](./examples/), that is to provide the chart with your REDCap Community credentials via a Secret. You can then simply use the REDCap "one click update" feature to update your installation via the Control Center. 

- *How can I manage backups?*

  If you're going with the backup/restore feature of this Chart, every backup will contain the redcap application directory, the edocs directory, and a database dump, so you'll be able to restore everything in one go. You're of course free to use any other method!

- *I can't get the REDCap application via the community website because my admins won't whitelist the URL/whatever other reasons!*

  You can override the initContainer in charge of retrieving the REDCap application, and add as many other initContainers you like to build your own retrieval logic. It might take some time to get into the logic, but you can help yourself with the few snippets presents [in the example directory](./examples/snippets/).

## Continuous Integration / Continuous Delivery

This project contains a Github Workflow, which will :
- Lint the Chart using `helm ct`
- Verify the generated Kubernetes resources using `Kubeconform`
- Scan the Chart for anti-patterns and security issues using `Polaris`  
- Validates the Chart deployment on `KinD` using `helm ct`
- Package en release the chart on Github using `helm-cr`

## How can I contribute?

You're welcome to read the [contribution guidelines](./CONTRIBUTING.md).

## How is this project licensed?

The informations about the licensing and the dependencies of this project can be found under : 
- The [project's license file](./LICENSE)
- The [legal notice](./NOTICE)