# MLA

In this lab you will setup an MLA stack.

## trivy

```bash
# https://artifacthub.io/packages/helm/trivy-operator/trivy-operator
helm repo add trivy-operator https://aquasecurity.github.io/helm-charts/
helm repo update


helm --namespace trivy --create-namespace --atomic --debug \
  upgrade --install \
  trivy-operator trivy-operator/trivy-operator --version 0.25.0 \
  --values trivy-operator-values.yaml


trivy_image_vulnerabilities{resource_name="my-suboptimal-pod"}  

# helm --namespace trivy --create-namespace --atomic --debug \
#   upgrade --install \
#   trivy-operator trivy-operator/trivy-operator --version 0.25.0 \
#     --set serviceMonitor.enabled=true \
#     --set trivy.ignoreUnfixed=true 
#     # --set service.type=NodePort \
#     # --set service.headless=false \
#     # --set service.nodePort=30111 \
#     # --set serviceMonitor.namespace=mla

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

kubectl apply -f disallow-latest-tag.yaml

# https://kyverno.io/docs/monitoring/

```
Update Complete. ⎈Happy Helming!⎈
history.go:56: 2024-12-12 10:57:00.395588837 +0000 UTC m=+0.101596918 [debug] getting history for release kyverno
Release "kyverno" does not exist. Installing it now.
install.go:224: 2024-12-12 10:57:02.924702218 +0000 UTC m=+2.630710297 [debug] Original chart version: "3.3.4"
install.go:241: 2024-12-12 10:57:03.064021012 +0000 UTC m=+2.770029111 [debug] CHART PATH: /root/.cache/helm/repository/kyverno-3.3.4.tgz


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

# helm --namespace mla --create-namespace --atomic --debug \
#   upgrade --install \
#   prometheus prometheus-community/kube-prometheus-stack --version v66.3.1 \
#     --set alertmanager.service.type=NodePort \
#     --set prometheus.service.type=NodePort \
#     --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=true \
#     --set prometheus.prometheusSpec.serviceMonitorSelector="" \
#     --set prometheus.prometheusSpec.serviceMonitorNamespaceSelector="" \
#     --set grafana.enabled=false
    
# verify
kubectl --namespace mla get pods
kubectl --namespace mla get svc

# visit urls
make get-external-ip # in different cloud shell
# visit prometheus => http://EXTERNAL_IP:30090
# visit alertmanager => http://EXTERNAL_IP:30903
```

<!-- TODO -->
## Loki

```bash
# https://artifacthub.io/packages/helm/grafana/loki-stack

```

<!-- TODO -->
## Grafana

