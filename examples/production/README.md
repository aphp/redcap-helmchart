# Production-grade installation

This example provides with a more robust qnd secure deployment of REDCap.

## Pre-requisites

You'll need to fulfill the following points before deploying this chart:
- Have production-grade Kubernetes cluster ready with `NetworkPolicies` support
- Have a robust CSI (Container Storage Interface) like `Rook`, `Ceph` or `Cinder`, that allows you to provision `PersistentVolumes` for the application
- Have a certificate to sign your Ingress HTTPS endpoint
- Have a secured email server that REDCap can connect to in order to send and manage administration emails
- [OPTIONAL] Have an S3 bucket ready to store backups
- [OPTIONAL] Have an audit stack like `ELK` or `Graylog`, with an API ready to receive REDCap audit logs

## Installation

## Secret creation

You'll first need to create the Secret needed to hold all the sensitive information REDCap will need :

- HTTPS TLS certificate : 
```sh
kubectl -n redcap create secret tls redcap-prod-tls --cert=path/to/your/cert/file --key=path/to/your/key/file 
```
- REDCap Community credentials : 
```sh
kubectl -n redcap create secret generic redcap-prod-community-credentials --from-literal USERNAME='my-username' --from-literal PASSWORD='my-password'
```
- Database Salt : 
```sh
kubectl -n redcap create secret generic redcap-prod-database-salt --from-literal salt='generated-salt'
```
- Database credentials : 
```sh
kubectl -n redcap create secret generic redcap-prod-mysql-passwd --from-literal mysql-password='generated-mysql-password'
```
- Email server password: 
```sh
kubectl -n redcap create secret generic redcap-prod-msmtp-passwd --from-literal MAIL_PASSWORD='mail-server-password'
```
- [OPTIONAL] S3 Bucket credentials (for hosting backups): 
```sh
kubectl -n redcap create secret generic redcap-prod-s3-creds --from-literal ACCESS_KEY_ID='s3-access-key-id' --from-literal SECRET_ACCESS_KEY='s3-secret-access-key'
```
- [OPTIONAL] Audit Logs API token
```sh
kubectl -n redcap create secret generic redcap-prod-audit-token--from-literal TOKEN='logs-api-token'
```

## Configuration review
Take the `values.yaml` file in this directory as an example, and review it according to your needs.
After ensuring that everything is OK, proceed with the next step.

**Note** : If you're not using the features tagged as [OPTIONAL] in this documentation, you can disable them by marking `enabled: false` :
- Line 113 for the Backup Cronjob
- Line 137 for the Restore Job
- Line 164 for the Audit component

## Installation
To install REDCap, follow those steps :

- Add this Helm Repository to your Helm installation : 
  ```sh
  helm repo add aphp-redcap https://aphp.github.io/redcap-helmchart
  ```
- Update your Helm repositories :
  ```sh
  helm repo update
  ```
- Create the namespace that will contain the REDCap installation : 
  ```
  kubectl create namespace redcap
  ```
- Install this chart using this values file : 
  ```sh
  helm upgrade --install -n redcap redcap aphp-redcap/redcap -f ./examples/production/values.yaml --wait --wait-for-jobs
  ```

## Post-installation
You can access REDCap with the following URL : https://your-recap-host:443.

The auto-install feature doesn't fully configure the REDCap installation, hence you'll need to do those post-installation actions in the REDCap Control Center as soon as possible : 
- Set the `REDCap base URL`
- Set the `Local Server File Storage` path to `/edocs`
- Set an authentication method
- Checks that the CronJobs were called (you can manually launch one if the Kubernetes CronJob dedicated to this task hasn't run yet)
- Launch the `Configuration Check`

Then, finish the configuration of your REDCap installation according to your needs.