# Image Scanning via Trivy

## Run Trivy localy

### Installation

```bash

# Install
apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install trivy --yes

# Verify installation
trivy --version
```

### Scan Container Images

```bash
# scan the latest image of nginx
trivy image nginx

# scan for critical issues of the latest image of nginx
trivy image --severity CRITICAL nginx

# scan the latest alpine image
trivy image alpine

# scan an older elasticsearch image
# note that the report contains Log4Shell CVE-2021-44228 => so, also the dependencies of the application get scanned
trivy image --severity CRITICAL elasticsearch:6.8.21

# scan the kubernetes cluster
trivy k8s --report summary
trivy k8s --include-namespaces default --report=summary
trivy k8s --include-namespaces default --severity MEDIUM --report=summary
trivy k8s --include-namespaces default --severity MEDIUM,HIGH,CRITICAL --report=summary
trivy k8s --include-namespaces default --severity MEDIUM,HIGH,CRITICAL --report all

# => fix issues

# exit code for CI/CD
trivy k8s --help | grep exit

# .trivyignore
trivy k8s --include-namespaces default --severity HIGH,CRITICAL --report all
echo "AVD-KSV-0121" > .trivyignore
trivy k8s --include-namespaces default --severity HIGH,CRITICAL --report all
```

## Run Trivy via Operator

```bash

# https://github.com/aquasecurity/trivy-operator
# https://artifacthub.io/packages/helm/trivy-operator/trivy-operator

helm repo add aqua https://aquasecurity.github.io/helm-charts/
helm repo update

helm --namespace trivy --create-namespace --atomic --debug \
  upgrade --install \
  trivy-operator aqua/trivy-operator --version 0.21.4

helm --namespace trivy --create-namespace --debug \
  upgrade --install \
  trivy-operator aqua/trivy-operator --version 0.21.4


kubectl get vulnerabilityreports -o wide

compliance.cron
excludeNamespaces


```

## Run Trivy as an Admission Plugin

```bash
# TODO
```
