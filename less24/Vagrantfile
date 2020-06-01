# -*- mode: ruby -*-
# vi: set ft=ruby :
Mashines = {
    :r1 => {
    },
    :r2 => {
    },
}

Vagrant.configure(2) do |config|
    config.vm.box = "centos/7"
    config.vm.box_version = "1905.1"
  
    config.vm.provider "virtualbox" do |v|
      v.memory = 256
      v.cpus = 1
    end
  
    config.vm.define "r1" do |r1|
      r1.vm.network "private_network", ip: "172.16.10.10"
      r1.vm.network "private_network", ip: "1.1.1.1", virtualbox__intnet: "inet"
      r1.vm.network "private_network", ip: "192.168.10.1", virtualbox__intnet: "localR1"
      r1.vm.hostname = "r1"
    end
  
    config.vm.define "r2" do |r2|
      r2.vm.network "private_network", ip: "172.16.10.20"
      r2.vm.network "private_network", ip: "1.1.1.2", virtualbox__intnet: "inet"
      r2.vm.network "private_network", ip: "192.168.20.1", virtualbox__intnet: "localR2"
      r2.vm.hostname = "r2"
    end

    config.vm.provision "shell", inline: <<-SHELL
    mkdir -p ~root/.ssh
    cp ~vagrant/.ssh/auth* ~root/.ssh
    sed -i '65s/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        systemctl restart sshd
    sudo yum install -y epel-release
    sudo yum install -y ansible
    name=`hostname`
    SHELL

    config.vm.provision :ansible do |ansible|
    ansible.inventory_path = "inventories/all.yml"
    ansible.limit = $name
        ansible.playbook = "less24.yml"
    end	
  end