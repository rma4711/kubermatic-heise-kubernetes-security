# Agenda

## Session 1

- Einleitung
  - Die Architektur von Kubernetes
  - Wie kann ich Kubernetes installieren?
- Kubelet
  - Absichern der Kubelets
- Berechtigungen
  - Das Berechtigungssytem in Kubernetes
- Network Policy
  - Firewalls innerhalb der Kubernetes-Cluster

## Session 2

- Verschlüsselung
  - Verschlüsselung bei der Verwendung der Daten
  - Verschlüsselung der Daten im Transport
  - Verschlüsselung der Daten im Ruhezustand
  - Verschlüsselung der Daten in Backups
  - Alternativen zu etcd als Secret Store

## Session 3

- Statische Pod-Analyse
  - Statische Analyse von Pods via kubesec
- Image Scanning
  - Scannen der Container Images via trivy
- Admission Plugins
  - Wie funktionieren Admission Plugins?
  - Ein Rückblick auf PodSecurityPolicies
  - Validierung von Manifesten via Kyverno

## Session 4

- Linux Security Module
  - Was sind Linux Security Modele?
  - Sicherheit auf Host Level via AppArmor
- Container Sandboxing
  - Unterschiede von Container Runtimes bezüglich Sicherheit
  - Container Sandboxing via gvisor

## Session 5

- Monitoring
  - Auditing in Kubernetes
  - Gefahrenerkennung via Falco
- Benchmarking
  - Wie kann ich meinen Cluster bezüglich Sicherheit benchmarken via kube-bench
