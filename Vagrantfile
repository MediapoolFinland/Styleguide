# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config/config.yaml")
vagrant_config = configs['configs'][configs['configs']['use']]

Vagrant.configure(2) do |config|
 config.vm.box = "hashicorp/precise32"

 config.vm.network "forwarded_port", guest: 80, host: 8080
 config.vm.network "private_network", ip: "192.168.33.10"

 # config.vm.synced_folder "./wordpress", "/var/www/wordpress", owner: "www-data", group: "www-data"

 # Faster settings (cannot set folder owner&group with nfs on)
 # config.vm.synced_folder "./wordpress", "/var/www/wordpress", nfs: true
 # config.vm.synced_folder "./wp-theme", "/var/www/wordpress/wp-content/themes/wp-theme", nfs: true

 config.vm.provision "shell" do |s|
   s.path = "#{current_dir}/config/server.sh"
   s.args = [vagrant_config['db'], vagrant_config['db_usr'], vagrant_config['db_pass'], vagrant_config['db_pass_root']]
 end
end