Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 4
  end

  config.vm.define :dockerhost do |config|
    config.vm.box = "ubuntu/focal64" # 20.04
    config.vm.network "private_network", ip: ENV["LRD_DOCKER_HOST_IP"] || "192.168.33.11"

    config.vm.network "forwarded_port", guest: 8000, host: 8000
    config.vm.network "forwarded_port", guest: 8001, host: 8001
    config.vm.network "forwarded_port", guest: 8002, host: 8002
    config.vm.network "forwarded_port", guest: 8003, host: 8003
    config.vm.network "forwarded_port", guest: 8004, host: 8004
    config.vm.network "forwarded_port", guest: 8005, host: 8005

    config.vm.network "forwarded_port", guest: 8080, host: 8080
    config.vm.network "forwarded_port", guest: 8443, host: 8443

    config.vm.network "forwarded_port", guest: 9000, host: 9000
    config.vm.network "forwarded_port", guest: 9001, host: 9001
    config.vm.network "forwarded_port", guest: 9002, host: 9002
    config.vm.network "forwarded_port", guest: 9003, host: 9003
    config.vm.network "forwarded_port", guest: 9004, host: 9004
    config.vm.network "forwarded_port", guest: 9005, host: 9005

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
      curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      chmod +x /usr/local/bin/docker-compose

      . /etc/os-release
      echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
      curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | apt-key add -
      apt-get update
      apt-get -y upgrade
      apt-get -y install podman

      mkdir /lrd
      git clone "https://lucasbasquerotto@github.com/lucasbasquerotto/root.git" /lrd
	  echo "$(date '+%F %T') setup ended"
      chown -R vagrant:vagrant /lrd
    EOF
  end
end