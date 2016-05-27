#
# Cookbook Name:: dafne_online
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt::default'

group 'admin'

user 'rails' do
  comment 'Rails User'
  gid 'admin'
  shell '/bin/bash'
  home '/home/rails'
  password data_bag_item('passwords', 'rails')['password']
end

%w(/home/rails /home/rails/apps).each do |dir|
  directory dir do
    owner 'rails'
    group 'admin'
  end
end

include_recipe 'br-ruby::default'

include_recipe 'dafne_online::nginx'

include_recipe 'dafne_online::mysql'

include_recipe 'dafne_online::application'
