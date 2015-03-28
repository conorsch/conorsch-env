# -*- mode: ruby -*-
# vi: set ft=ruby :

# small vagrant file for testing dotfiles
# and sandboxing new packages

Vagrant.configure(2) do |config|
  config.vm.box = "trusty64"
  config.ssh.port = 2222
  config.vm.define :testbox do |t|
  end
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "tests/test_vagrant.yml"
    ansible.groups = {
      "vagrant" => ["testbox"],
    }
    ansible.extra_vars = {
      ansible_ssh_port: config.ssh.port,
      include_graphical_packages: true,
    }
    ansible.verbose = "vvvv"
  end
end
