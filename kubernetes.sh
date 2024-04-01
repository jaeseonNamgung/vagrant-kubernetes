sudo ufw disable

echo "y" | sudo ufw enable


sudo swapoff -a && sudo sed -i '/swap/s/^/#/' /etc/fstab

echo "br_netfilter" | sudo tee /etc/modules-load.d/k8s.conf

printf "net.bridge.bridge-nf-call-ip6tables = 1\nnet.bridge.bridge-nf-call-iptables = 1\n" | sudo tee /etc/sysctl.d/k8s.conf

sudo sysctl --system

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

echo "y" | curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.24/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.24/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet


