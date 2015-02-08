# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "mac-osx-10-10"
  config.vm.box_url = "./mac-osx-10-10.box"

  config.ssh.insert_key = false

  # Prevent asking for password when no GUI is available
  config.vm.provision "shell", path: "./provision/setup-keychain.sh",
    privileged: false

  config.vm.define "base" do |base|
  end

  config.vm.define "brew" do |brew|
    config.vm.provision "shell", path: "./provision/install-homebrew.sh",
      privileged: false
  end

  config.vm.define "boxen" do |boxen|
    boxen.vm.synced_folder "our-boxen", "/opt/boxen/repo", type: "nfs"

    boxen.vm.provision "shell", path: "./provision/setup-boxen.sh",
      args: [ (ENV['GH_TOKEN'] || ""), (ENV['UNLOCK_BOXEN'] || "" ) ],
      privileged: false
  end
end
