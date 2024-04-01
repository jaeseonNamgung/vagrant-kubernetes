# 자동 생성 설정
sudo apt-get -y install bash-completion
source /etc/bash_completion
source <(kubectl completion bash) 
echo "source <(kubectl completion bash)" >> ~/.bashrc 
source <(kubeadm completion bash) 
echo "source <(kubeadm completion bash)" >> ~/.bashrc