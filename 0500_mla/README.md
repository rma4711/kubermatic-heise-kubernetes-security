# MLA

In this lab you will setup an MLA stack.

## Prometheus

```bash
# # https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack
# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
# helm repo update
# helm --namespace mla --create-namespace --atomic --debug \
#   upgrade --install \
#   prometheus prometheus-community/kube-prometheus-stack --version v66.3.1

does not work try this shit prom-operator https://medium.com/@platform.engineers/setting-up-a-prometheus-and-grafana-monitoring-stack-from-scratch-63667bf3e011

or this shit https://github.com/kubermatic/kubermatic/blob/main/charts/monitoring/prometheus/Chart.yaml

# verify
kubectl --namespace mla get pods -l "release=prometheus

# visit grafana
kubectl port-forward svc/prometheus-stack-grafana -n monitoring 3000:3000 &
kubectl -n mla port-forward service/prometheus-grafana 8080:80

# https://artifacthub.io/packages/helm/prometheus-community/prometheus

```

## Loki

```bash
# https://artifacthub.io/packages/helm/grafana/loki-stack

```

## Grafana

