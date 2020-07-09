Vagrant.configure(2) do |config|
  config.vm.synced_folder "./ctl/", "/lrd/ctl", id: "ctl", 
     owner: "vagrant",
     mount_options: ["dmode=700,fmode=700"]
  config.vm.synced_folder "./envs/", "/lrd/envs", id: "envs", 
     owner: "vagrant",
     mount_options: ["dmode=700,fmode=700"]
  config.vm.synced_folder "./clouds/", "/lrd/clouds", id: "clouds", 
     owner: "vagrant",
     mount_options: ["dmode=700,fmode=744"]
  config.vm.synced_folder "./pods/", "/lrd/pods", id: "pods", 
     owner: "vagrant",
     mount_options: ["dmode=755,fmode=744"]
  config.vm.synced_folder "./apps/", "/lrd/apps", id: "apps", 
     owner: "vagrant",
     mount_options: ["dmode=755,fmode=644"]
  config.vm.synced_folder "./data/", "/lrd/data", id: "data", 
     owner: "vagrant",
     mount_options: ["dmode=777,fmode=666"]
  config.vm.synced_folder "./bin/", "/lrd/bin", id: "bin", 
     owner: "vagrant",
     mount_options: ["dmode=700,fmode=700"]
  config.vm.synced_folder "./w/", "/lrd/w", id: "w", 
     owner: "vagrant",
     mount_options: ["dmode=700,fmode=600"]

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 4
  end

  config.vm.define :dockerhost do |config|
    config.vm.box = "ubuntu/xenial64"
    config.vm.network "private_network", ip: ENV["LRD_DOCKER_HOST_IP"] || "192.168.33.11"
    config.vm.network "forwarded_port", guest: 8080, host: 8080
    config.vm.network "forwarded_port", guest: 8443, host: 8443
    config.vm.network "forwarded_port", guest: 9080, host: 9080
    config.vm.network "forwarded_port", guest: 9443, host: 9443

    if Vagrant.has_plugin?("vagrant-disksize")
      config.disksize.size = ENV["LRD_DOCKER_HOST_DISKSIZE"] || "50GB"
    else
      raise "The vagrant-disksize plugin required to expand the vm disk size. " +
            "Run 'vagrant plugin install vagrant-disksize'."
    end

    if ENV["http_proxy"]
      config.vm.provision "shell", inline: <<-EOF
        echo "Acquire::http::Proxy \\"#{ENV['http_proxy']}\\";" >/etc/apt/apt.conf.d/50proxy
        echo "http_proxy=\"#{ENV['http_proxy']}\"" >/etc/profile.d/http_proxy.sh
      EOF
    end

    config.vm.provision "shell", inline: <<-EOF
      set -e
      export DEBIAN_FRONTEND=noninteractive
      echo "en_US.UTF-8 UTF-8" >/etc/locale.gen
      locale-gen
      echo "Apt::Install-Recommends 'false';" >/etc/apt/apt.conf.d/02no-recommends
      echo "Acquire::Languages { 'none' };" >/etc/apt/apt.conf.d/05no-languages
      apt-get update
      wget -qO- https://get.docker.com/ | sh
	  curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(un
ame -m)" -o /usr/local/bin/docker-compose
	  chmod +x /usr/local/bin/docker-compose
    EOF
  end
end