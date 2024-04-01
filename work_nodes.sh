#!/usr/bin/env bash
sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd
# config for work_nodes only 
sudo kubeadm join --token 123456.1234567890123456 --discovery-token-unsafe-skip-ca-verification 192.168.1.20:6443
sudo ufw disable