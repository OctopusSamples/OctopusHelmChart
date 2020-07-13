# Octopus Helm Chart

This Helm chart deploys a HA Octopus cluster (or a standalone Octopus instance when the replica count is 1).

This chart is available from the repository hosted at https://octopus-helm-charts.s3.amazonaws.com.

This chart uses the mssql-linux chart as a dependency. See https://github.com/helm/charts/tree/master/stable/mssql-linux for details on configuring that chart.

# Deploying

Install the S3 plugin with the command:

```
helm plugin install https://github.com/hypnoglow/helm-s3.git
```

Add the repo with the command:

```
helm repo add octopus-helm-charts s3://octopus-helm-charts
```

Package the chart with the command:

```
helm package .
```

Push the package with the command:

```
helm s3 push octopuschart.0.1.1.tgz octopus-helm-charts
```

The bucket can be found at https://s3.console.aws.amazon.com/s3/buckets/octopus-helm-charts/?region=us-east-1&tab=overview.