Vagrant.configure("2") do |config|
  N = 2 # max number of worker nodes
  #=============#
  # Master Node #
  #=============#

    config.vm.define "master-k8s" do |cfg|
      cfg.vm.box = "bento/ubuntu-20.04"
      cfg.vm.provider "virtualbox" do |vb|
        vb.name = "master-k8s"
        vb.cpus = 2
        vb.memory = 3072
        vb.customize ["modifyvm", :id, "--groups", "/k8s"]
      end
      cfg.vm.host_name = "master-k8s"
      cfg.vm.network "private_network", ip: "192.168.1.20"
      cfg.vm.network "forwarded_port", guest: 22, host: 60010, auto_correct: true, id: "ssh"
      cfg.vm.synced_folder "../data", "/vagrant", disabled: true 
      cfg.vm.provision "shell", path: "docker.sh"
      cfg.vm.provision "shell", path: "kubernetes.sh"
      cfg.vm.provision "shell", path: "master_node.sh"
      cfg.vm.provision "shell", path: "config.sh"
    end

  #==============#
  # Worker Nodes #
  #==============#

  (1..N).each do |i|
    config.vm.define "work#{i}-k8s" do |cfg|
      cfg.vm.box = "bento/ubuntu-20.04"
      cfg.vm.provider "virtualbox" do |vb|
        vb.name = "work#{i}-k8s"
        vb.cpus = 1
        vb.memory = 2560
        vb.customize ["modifyvm", :id, "--groups", "/k8s"]
      end
      cfg.vm.host_name = "work#{i}-k8s"
      cfg.vm.network "private_network", ip: "192.168.1.20#{i}"
      cfg.vm.network "forwarded_port", guest: 22, host: "6010#{i}", auto_correct: true, id: "ssh"
      cfg.vm.synced_folder "../data", "/vagrant", disabled: true
      cfg.vm.provision "shell", path: "docker.sh"
      cfg.vm.provision "shell", path: "kubernetes.sh"
      cfg.vm.provision "shell", path: "work_nodes.sh"
      cfg.vm.provision "shell", path: "config.sh"
    end
  end

end