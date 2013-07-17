# -*- mode: ruby -*-
# vim: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "base-hadoop"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "base-hadoop.pp"
     puppet.module_path = "modules"
  end
  
  config.vm.define :hadoop1 do |hadoop1_config|
    hadoop1_config.vm.network :private_network, ip: "192.168.7.12"
    hadoop1_config.vm.provider :virtualbox do |v|
        v.name = "hadoop1"
        v.customize ["modifyvm", :id, "--memory", "1024"]
    end
  end
  
  config.vm.define :hadoop2 do |hadoop2_config|
    hadoop2_config.vm.network :private_network, ip: "192.168.7.13"
    hadoop2_config.vm.provider :virtualbox do |v|
        v.name = "hadoop2"
        v.customize ["modifyvm", :id, "--memory", "1024"]
    end
  end
  
  config.vm.define :hadoop3 do |hadoop3_config|
    hadoop3_config.vm.network :private_network, ip: "192.168.7.14"
    hadoop3_config.vm.provider :virtualbox do |v|
        v.name = "hadoop3"
        v.customize ["modifyvm", :id, "--memory", "1024"]
    end
  end
  
   config.vm.define :master do |master_config|
    master_config.vm.network :private_network, ip: "192.168.7.10"
    master_config.vm.provider :virtualbox do |v|
        v.name = "master"
        v.customize ["modifyvm", :id, "--memory", "1024"]
    end
  end

end
