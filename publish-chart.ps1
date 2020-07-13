helm package .
aws s3 cp s3://octopus-helm-charts/index.yaml .
helm repo index . --url https://octopus-helm-charts.s3.amazonaws.com --merge index.yaml
ls
aws s3 cp *.tgz s3://octopus-helm-charts
aws s3 cp index.yaml s3://octopus-helm-charts