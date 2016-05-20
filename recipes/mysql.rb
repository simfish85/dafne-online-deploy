#
# Cookbook Name:: dafne_online
# Recipe:: mysql
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
mysql_root = data_bag_item('passwords', 'mysql_root')


mysql_service 'dafne_online' do
  port '3306'
  version '5.6'
  initial_root_password mysql_root['password']
  action [:create, :start]
end

mysql2_chef_gem 'default' do
  action :install
end

mysql_root_connection = {
  :host => '127.0.0.1',
  :username => 'root',
  :socket   => "/var/run/mysql-#{node['dafne_online']['mysql']['instance_name']}/mysqld.sock",
  :password => mysql_root['password']
}

# Create a mysql database on a named mysql instance
mysql_database node['dafne_online']['mysql']['database'] do
  connection mysql_root_connection
  action :create
end

cookbook_file '/tmp/db_schema.sql' do
  source 'db_schema.sql'
  mode 00644
end

ruby_block 'modifying MySQL2 client' do
  block do
    Mysql2::Client.default_query_options[:connect_flags] |= Mysql2::Client::MULTI_STATEMENTS
  end
  action :run
end

# Query a database from a sql script on disk
mysql_database node['dafne_online']['mysql']['database'] do
  connection mysql_root_connection
  sql { ::File.open('/tmp/db_schema.sql').read }
  action :query
end

# Grant SELECT, UPDATE, and INSERT privileges to all tables in foo db from all hosts
mysql_database_user node['dafne_online']['mysql']['user'] do
  connection    mysql_root_connection
  password      mysql_root['password']
  database_name node['dafne_online']['mysql']['database']
  action        :grant
end
