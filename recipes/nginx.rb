#
# Cookbook Name:: dafne_online
# Recipe:: nginx
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'nginx::default'

directory "#{node['dafne_online']['deploy_base']}/shared/config" do
  owner 'rails'
  group 'admin'
  recursive true
end

link "/etc/nginx/sites-enabled/#{node['dafne_online']['app_name']}" do
  to "#{node['dafne_online']['deploy_base']}/shared/config/nginx.conf"
  mode '0777'
end

template "#{node['dafne_online']['deploy_base']}/shared/config/nginx.conf" do
  source 'nginx_conf.erb'
  owner 'rails'
  group 'admin'
  mode '0644'
  notifies :restart, 'service[nginx]'
end
