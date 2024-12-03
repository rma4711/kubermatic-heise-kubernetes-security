# Admission Control with Kyverno

## Installation

```bash
# https://artifacthub.io/packages/helm/kyverno/kyverno

# install
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
helm --namespace kyverno --create-namespace --atomic --debug \
  upgrade --install \
  kyverno kyverno/kyverno --version v3.3.3

# verify
helm list -n kyverno
```

## Inspect installation

```bash
# check webhooks
kubectl get validatingwebhookconfigurations

# check deployments
kubectl -n kyverno get deployment
```

## Apply a ClusterPolicy

### Avoid new Pods breaking policys

```log

<!-- TODO problem in lab -->

The Pod "my-suboptimal-pod" is invalid: spec.containers[0].securityContext: Invalid value: core.SecurityContext{Capabilities:(*core.Capabilities)(nil), Privileged:(*bool)(0xc02348235d), SELinuxOptions:(*core.SELinuxOptions)(nil), WindowsOptions:(*core.WindowsSecurityContextOptions)(nil), RunAsUser:(*int64)(0xc023482360), RunAsGroup:(*int64)(nil), RunAsNonRoot:(*bool)(0xc02348235f), ReadOnlyRootFilesystem:(*bool)(0xc02348235e), AllowPrivilegeEscalation:(*bool)(0xc02348235c), ProcMount:(*core.ProcMountType)(nil), SeccompProfile:(*core.SeccompProfile)(nil)}: cannot set `allowPrivilegeEscalation` to false and `privileged` to true

=> invalid yaml  :)
```

```bash
# inspect the cluster policy
cat 0304_kyverno/disallow-latest-tag.yaml

# show policies repo
# https://github.com/kyverno/policies/

# apply the cluster policy
kubectl apply -f 0304_kyverno/disallow-latest-tag.yaml

# delete the pod
kubectl delete pod my-suboptimal-pod

# try to apply the pod - note you will get an error due to no image tag is provided
kubectl apply -f pod.yaml

# add the image tag to the image, eg `image: ubuntu:22.04`. Re-run the apply command. Now it works again
kubectl apply -f pod.yaml
```

### Report existing Pods breaking policys

```bash
# delete the policy
kubectl delete -f 0304_kyverno/disallow-latest-tag.yaml

# remove the image tag in the pod and create the pod
kubectl apply -f pod.yaml

# change the background flag in the policy to `true`
vi 0304_kyverno/disallow-latest-tag.yaml

# apply the cluster policy
kubectl apply -f 0304_kyverno/disallow-latest-tag.yaml

# pod is still running
kubectl get pods

# check reports
kubectl get policyreports
kubectl describe policyreports <REPORT>
```

## Cleanup

```bash
helm --namespace kyverno delete kyverno --debug
```
