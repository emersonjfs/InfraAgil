#-*- mode: ruby -*-
# vi: set ft=ruby :

machines = {
  "automation" => {"memory" => "1536", "cpu" => "2","ip" => "10","image" => "generic/centos8"},
  "compliance" => {"memory" => "1024", "cpu" => "2","ip" => "20","image" => "generic/ubuntu2204"},
   "container" => {"memory" => "1536", "cpu" => "1","ip" => "30","image" => "generic/centos8"},
         "scm" => {"memory" => "256",  "cpu" => "1","ip" => "40","image" => "debian/bullseye64"},
         "log" => {"memory" => "2048", "cpu" => "1","ip" => "50","image" => "generic/ubuntu2204"}
}

Vagrant.configure("2") do |config|

  config.vm.box_check_update = false
  config.vm.boot_timeout = 600
  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}.maximus.tech"
      machine.vm.network "private_network", ip: "10.5.25.#{conf["ip"]}"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        vb.customize ["modifyvm", :id, "--groups", "/InfraAgil"]
        
          if name == "automation" and not File.file?('iscsi525.vdi')
            vb.customize ['createhd', '--filename', 'iscsi525.vdi','--size', 20 * 1024]
            vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata']
            vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', 'iscsi525.vdi']
          end

          if "#{conf["image"]}" == "generic/ubuntu2204" or "#{conf["image"]}" == "debian/bullseye64"
            machine.vm.provision "shell", inline: "apt-get update ; apt-get install python -y ; hostnamectl set-hostname #{name}.maximus.tech"
          end

      end
    end
   end
   config.vm.provision "shell", path:"script.sh"
end 