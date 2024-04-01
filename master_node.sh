#!/usr/bin/env bash
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd
sudo kubeadm config images pull
# init kubernetes 
sudo kubeadm init --token 123456.1234567890123456 --token-ttl 0 --pod-network-cidr=172.16.0.0/16 --apiserver-advertise-address=192.168.1.20

# config for master node only 
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# config for kubernetes's network 
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

sudo ufw disable


# install ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.0/deploy/static/provider/cloud/deploy.yaml

