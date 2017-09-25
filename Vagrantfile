Vagrant.configure(2) do |config|
  config.vm.box = "williamyeh/ubuntu-trusty64-docker"

  config.vm.provision "shell", inline: <<-SHELL
    cd /vagrant

    docker build  -t ansible:ubuntu14.04          ubuntu14.04
    docker build  -t ansible:ubuntu16.04          ubuntu16.04
    docker build  -t ansible:ubuntu14.04-onbuild  ubuntu14.04-onbuild
    docker build  -t ansible:ubuntu16.04-onbuild  ubuntu16.04-onbuild
  SHELL
end
