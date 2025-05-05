Vagrant.configure("2") do |config|
  # Configuration commune
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
    vb.cpus = 2
  end

  # Contrôleur de domaine Samba AD
  config.vm.define "dc" do |dc|
    dc.vm.box = "ubuntu/jammy64"
    dc.vm.hostname = "dc"
    dc.vm.network "private_network", ip: "192.168.56.10"

    dc.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/samba.yml"
      ansible.inventory_path = "ansible/inventory"
      ansible.limit = "dc"
      ansible.compatibility_mode = "2.0"
    end
  end

  # Client Linux (Ubuntu)
  config.vm.define "linux-client" do |client|
    client.vm.box = "ubuntu/jammy64"
    client.vm.hostname = "linux-client"
    client.vm.network "private_network", ip: "192.168.56.11"

    client.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/linux-client.yml"
      ansible.inventory_path = "ansible/inventory"
      ansible.limit = "linux-client"
      ansible.compatibility_mode = "2.0"
    end
  end

  # Client Windows
  config.vm.define "windows-client" do |win|
    # Remplace par une box Windows valide selon ton système
    win.vm.box = "gusztavvargadr/windows-10"
    win.vm.hostname = "windows-client"
    win.vm.network "private_network", ip: "192.168.56.12"

    win.vm.communicator = "winrm"
    win.winrm.username = "vagrant"
    win.winrm.password = "vagrant"
    win.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 2
    end

    win.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/playbooks/windows-client.yml"
      ansible.inventory_path = "ansible/inventory"
      ansible.limit = "windows-client"
      ansible.compatibility_mode = "2.0"
    end
  end
end
