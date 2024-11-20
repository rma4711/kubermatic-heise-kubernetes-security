# Encryption at Rest

## Install etcdctl

```bash
apt install etcd-client
```

## Communication with etcd

```bash
# verify etcdctl is installed
etcdctl version

ETCDCTL_API=3 etcdctl \
  --cert /etc/kubernetes/pki/apiserver-etcd-client.crt \
  --key /etc/kubernetes/pki/apiserver-etcd-client.key \
  --cacert /etc/kubernetes/pki/etcd/ca.crt \
  member list

etcdctl member list

kubectl create cm my-cm --from-literal foo=bar
etcdctl get /registry/configmaps/default/my-cm
```

```bash
# verify etcd configuration
env | grep ETCD

# note that most of those values are taken from the etcd configuration
cat /etc/kubernetes/manifests/etcd.yaml

# set env vars for etcdctl
echo "export ETCDCTL_API=3" >> ~/.trainingrc
echo "export ETCDCTL_ENDPOINTS=https://127.0.0.1:2379" >> ~/.trainingrc
echo "export ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt" >> ~/.trainingrc
echo "export ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key" >> ~/.trainingrc
echo "export ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt" >> ~/.trainingrc
```
