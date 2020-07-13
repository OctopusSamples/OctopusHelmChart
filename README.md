# Octopus Helm Chart

This Helm chart deploys a HA Octopus cluster (or a standalone Octopus instance when the replica count is 1).

This chart is available from the repository hosted at https://octopus-helm-charts.s3.amazonaws.com.

This chart uses the mssql-linux chart as a dependency. See https://github.com/helm/charts/tree/master/stable/mssql-linux for details on configuring that chart.

# Deploying

Install the S3 plugin with the command:

Package the chart with the command:

```
helm package .
```

Download the existing index.yaml file:

```
aws s3 cp s3://octopus-helm-charts/index.yaml .
```

Push the package with the command:

```
helm repo index . --url https://octopus-helm-charts.s3.amazonaws.com --merge index.yaml
```

Upload the new files with the command

```
aws s3 cp *.tgz s3://octopus-helm-charts
aws s3 cp index.yaml s3://octopus-helm-charts
```

The bucket can be found at https://s3.console.aws.amazon.com/s3/buckets/octopus-helm-charts/?region=us-east-1&tab=overview.