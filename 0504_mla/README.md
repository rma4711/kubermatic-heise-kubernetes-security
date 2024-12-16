# MLA

In this lab you will setup an MLA stack for security.

```bash
cd 0504_mla
```

## Prometheus

```bash
# https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm --namespace mla --create-namespace --atomic --debug \
  upgrade --install \
  prometheus prometheus-community/kube-prometheus-stack --version v66.3.1 \
  --values prometheus-stack-values.yaml
  # TODO fix name and path


# kubectl get prometheuses.monitoring.coreos.com --all-namespaces -o yaml | grep -C5 serviceMonitorSelector
    
# verify
kubectl --namespace mla get pods
kubectl --namespace mla get svc

# visit urls
make get-external-ip # in different cloud shell
# visit prometheus => http://EXTERNAL_IP:30090
# visit alertmanager => http://EXTERNAL_IP:30903


# PromQL
trivy_image_vulnerabilities{resource_name="my-suboptimal-pod"}  

```

## trivy

```bash
# https://artifacthub.io/packages/helm/trivy-operator/trivy-operator
helm repo add trivy-operator https://aquasecurity.github.io/helm-charts/
helm repo update

helm --namespace trivy --create-namespace --atomic --debug \
  upgrade --install \
  trivy-operator trivy-operator/trivy-operator --version 0.25.0 \
  --values trivy-operator-values.yaml

kubectl -n trivy label servicemonitors trivy-operator release=prometheus
kubectl -n trivy get servicemonitors trivy-operator -o yaml

kubectl run ancient-elasticsearch --image elasticsearch:6.8.21

kubectl -n default get vulnerabilityreports -o wide

# https://github.com/vijaybiradar/Deploying-Trivy-Operator-with-kube-prometheus-stack-for-Enhanced-Kubernetes-Security
```


## kyverno

```bash
# https://artifacthub.io/packages/helm/kyverno/kyverno
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
helm --namespace kyverno --create-namespace --atomic --debug \
  upgrade --install \
  kyverno kyverno/kyverno --version 3.3.4 \
  --values kyverno-values.yaml

kubectl -n kyverno label servicemonitors kyverno-admission-controller release=prometheus
kubectl -n kyverno get servicemonitors kyverno-admission-controller -o yaml

kubectl apply -f disallow-latest-tag.yaml

kubectl get policyreports

# https://kyverno.io/docs/monitoring/

```
Update Complete. ⎈Happy Helming!⎈
history.go:56: 2024-12-12 10:57:00.395588837 +0000 UTC m=+0.101596918 [debug] getting history for release kyverno
Release "kyverno" does not exist. Installing it now.
install.go:224: 2024-12-12 10:57:02.924702218 +0000 UTC m=+2.630710297 [debug] Original chart version: "3.3.4"
install.go:241: 2024-12-12 10:57:03.064021012 +0000 UTC m=+2.770029111 [debug] CHART PATH: /root/.cache/helm/repository/kyverno-3.3.4.tgz

## Audit logs

## kube-bench

## Falco

```bash
# https://medium.com/@noah_h/kubernetes-security-tools-falco-e873831f3d3d

```

<!-- TODO -->
## Loki

```bash
# https://artifacthub.io/packages/helm/grafana/loki-stack

```

<!-- TODO -->
## Grafana

```bash

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm --namespace kyverno --create-namespace --atomic --debug \
  upgrade --install \
  grafana grafana/grafana --version 8.6.4 \
  --values grafana-values.yaml

```

