# Host Level Security with Seccomp

## Install

### Enable seccomp in kubelet

```bash
# /var/lib/kubelet/config
seccompDefault: true

systemctl restart kubelet
systemctl status kubelet
```

### Create custom profile

```bash
cat 0403_seccomp/my-profile.json

mkdir /var/lib/kubelet/seccomp/profiles
cp 0403_seccomp/my-profile.json /var/lib/kubelet/seccomp/profiles/
```

## Verify Pod is allowed to write files

```bash
kubectl exec my-suboptimal-pod -- touch /tmp/some.file
kubectl exec -it my-suboptimal-pod -- ls -alh /tmp
```

## Verify seccomp is working

### Enable profile

```yaml
---
spec:
  securityContext:
    seccompProfile:
      type: Localhost
      localhostProfile: profiles/my-profile.json
```

```bash
kubectl apply -f pod.yaml --force
```

## Verify

```bash
kubectl exec -it my-suboptimal-pod -- touch some.file
# => error message
```

## Teardown

```bash
# uncomment seccomp in pod
kubectl apply -f pod.yaml
```
