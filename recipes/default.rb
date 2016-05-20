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
end

include_recipe 'dafne_online::nginx'

include_recipe 'dafne_online::mysql'
