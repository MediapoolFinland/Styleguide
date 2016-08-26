# -*- mode: ruby -*-
# vi: set ft=ruby :

# Folder structure: 
# wordpress-folder/ 		(vagrant_config['wp_folder'])
# wp-theme-folder/ 			(vagrant_config['wp_folder_theme'])
# wp-plugins/ 				(vagrant_config['wp_folder_plugins'])
# Vagrant creates the symbolic links for you.

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config/config-vagrant.yaml")
vagrant_config = configs['configs'][configs['configs']['use']]

Vagrant.configure(2) do |config|
 config.vm.box = "hashicorp/precise32"

 config.vm.network "forwarded_port", guest: 80, host: 8080
 config.vm.network "private_network", ip: vagrant_config['ip']

 config.vm.synced_folder vagrant_config['wp_folder'], "/var/www/wordpress", owner: "www-data", group: "www-data"
 config.vm.synced_folder vagrant_config['wp_folder_theme'], "/var/www/wordpress/wp-content/themes/#{vagrant_config['wp_folder_theme']}", owner: "www-data", group: "www-data"
 config.vm.synced_folder vagrant_config['wp_folder_plugins'], "/var/www/wordpress/wp-content/plugins/", owner: "www-data", group: "www-data"

 config.vm.provision "shell" do |s|
   s.path = "#{current_dir}/config/server.sh"
   s.args = [vagrant_config['db_wp'], vagrant_config['db_wp_usr'], vagrant_config['db_wp_pass']]
 end
end