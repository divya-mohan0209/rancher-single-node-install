#!/bin/sh

echo "Installing K3S"
curl  -sfL https://get.k3s.io  | INSTALL_K3S_VERSION="1.24.9+k3s1" sh -s - --write-kubeconfig-mode 644

sudo chmod 747 /var/lib/rancher/k3s/server/manifests/ # Write permissions granted for other users not in the root usergroup. This currently doesn't work!

cat > /var/lib/rancher/k3s/server/manifests/rancher.yaml << EOF
apiVersion: v1
kind: Namespace
metadata:
  name: cattle-system
---
apiVersion: v1
kind: Namespace
metadata:
  name: cert-manager
  labels:
    certmanager.k8s.io/disable-validation: "true"
---
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  namespace: kube-system
  name: cert-manager
spec:
  targetNamespace: cert-manager
  version: v1.10.2
  chart: cert-manager
  repo: https://charts.jetstack.io
  set:
    installCRDs: "true"
---
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: rancher
  namespace: kube-system
spec:
  targetNamespace: cattle-system
  version: v2.7.0
  chart: rancher
  repo: https://releases.rancher.com/server-charts/latest
  set:
    ingress.tls.source: "letsEncrypt"
    letsEncrypt.ingress.class: "traefik"
    letsEncrypt.email: "MY-EMAIL"
    hostname: "MY-ADDRESS.sslip.io"
    antiAffinity: "required"
    replicas: 1
EOF

echo "Rancher should be booted up in a few mins"
