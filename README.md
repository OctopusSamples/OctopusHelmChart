# Octopus Helm Chart

This Helm chart deploys a HA Octopus cluster (or a standalone Octopus instance when the replica count is 1).

This chart is available from the repository hosted at https://octopus-helm-charts.s3.amazonaws.com.

This chart uses the mssql-linux chart as a dependency. See https://github.com/helm/charts/tree/master/stable/mssql-linux for details on configuring that chart.

Kuberenetes v1.16 is required to deploy this chart.

Generate a new master key with this command:

```
openssl rand 16 | base64
```

Deploy the chart with the command:

```
helm repo add octopus https://octopus-helm-charts.s3.amazonaws.com
helm repo update
helm install octopus octopus/octopusdeploy --set octopus.username=admin --set octopus.password=Password01! --set octopus.licenseKeyBase64=<your Octopus license key base64 encoded> --set octopus.acceptEula=Y --set mssql-linux.acceptEula.value=Y --set octopus.masterKey=YOUR_GENERATED_KEY
```

# Typical example of values

```
octopus:
  image: octopusdeploy/octopusdeploy:2020.5.266
  username: admin
  password: Password01!
  licenseKeyBase64: base 64 encoded license file goes here
  masterKey: build me with 'openssl rand 16 | base64'
  acceptEula: !!str "Y"
  replicaCount: 3
  storageClassName: "azurefile"
  pollingTentacles:
    exposeServices: true
mssql-linux:
  acceptEula:
    value: !!str "Y"
    
```

# Deploying

The chart can be built and published with the script `publish-chart.ps1`. The commands it uses are shown below.

Package the chart with the command:

```
helm package .
```

Download the existing index.yaml file:

```
aws s3 cp s3://octopus-helm-charts/index.yaml .
```

Create the new index with the command:

```
helm repo index . --url https://octopus-helm-charts.s3.amazonaws.com --merge index.yaml
```

Upload the new files with the command:

```
aws s3 cp octopusdeploy-0.1.0.tgz s3://octopus-helm-charts
aws s3 cp index.yaml s3://octopus-helm-charts
```

The bucket can be found at https://s3.console.aws.amazon.com/s3/buckets/octopus-helm-charts/?region=us-east-1&tab=overview.

# In Octopus

Create a new release at https://github.com/OctopusSamples/OctopusHelmChart/releases/new.

Run the deployment at https://deploy.octopushq.com/app#/Spaces-542/projects/octopus-server-helm-chart/deployments.

# Support

This repository is licensed under the [Apache 2.0](license) and provided as-is with no support.
