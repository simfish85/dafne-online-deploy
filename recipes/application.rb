#
# Cookbook Name:: dafne_online
# Recipe:: application
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'git' # Needed to clone the repo
package 'nodejs' # Needed for asset compilation
# These packages needed for nokogiri gem
package ['build-essential', 'patch', 'ruby-dev', 'zlib1g-dev', 'liblzma-dev', 'libxml2-dev']

shared_array = %w{bin log tmp/pids tmp/cache tmp/sockets public/system}
shared_hash = Hash[shared_array.zip(shared_array)]

shared_array.each do |dir|
  directory "#{node['dafne_online']['deploy_base']}/shared/#{dir}" do
    owner node['dafne_online']['deploy_user']
    group 'admin'
    mode 00755
    recursive true
    action :create
  end
end

mysql_password = data_bag_item('passwords', 'mysql_root')['password']

template "#{node['dafne_online']['deploy_base']}/shared/config/database.yml" do
  source 'database.yml.erb'
  owner node['dafne_online']['deploy_user']
  group 'admin'
  variables({:mysql_password => mysql_password })
  mode 00744
end

git_pw = data_bag_item('passwords', 'rails')['password']

rails_env = {
  'HOME' => "/home/#{node['dafne_online']['deploy_user']}",
  'USER' => node['dafne_online']['deploy_user'],
  'PATH' => "/opt/rubies/#{node['ruby']['versions'][0]}/bin:#{ENV['PATH']}"
  }

deploy node['dafne_online']['deploy_base'] do
  repository                 "https://#{node['dafne_online']['git_user']}:#{git_pw}@dafneonline.git.cloudforge.com/dafneonline.git"
  rollback_on_error          true
  environment 'RAILS_ENV' => 'production'
  restart_command 'sudo -H -u rails bash -c "export PATH=/opt/rubies/2.2.3/bin:$PATH && /etc/init.d/unicorn_dafneonline restart"'
  action :deploy
  symlinks shared_hash
  user node['dafne_online']['deploy_user']
  group 'admin'

  before_symlink do
    execute 'bundle install' do
      command "bundle install --path #{node['dafne_online']['deploy_base']}/shared/bundle --without development test --deployment --quiet"
      user node['dafne_online']['deploy_user']
      environment rails_env
      cwd release_path
      action :run
    end
  end

  before_restart do
    link '/etc/init.d/unicorn_dafneonline' do
      to '/home/rails/apps/dafneonline/current/config/unicorn_init.sh'
    end

    template "#{node['dafne_online']['deploy_base']}/current/config/unicorn.rb" do
      source 'unicorn.rb.erb'
      owner node['dafne_online']['deploy_user']
      group 'admin'
      mode 00744
    end

    execute 'compile assets' do
      command 'RAILS_ENV=production bundle exec rake assets:precompile'
      user node['dafne_online']['deploy_user']
      environment ({
        'HOME' => "/home/#{node['dafne_online']['deploy_user']}",
        'USER' => node['dafne_online']['deploy_user'],
        'PATH' => "/opt/rubies/#{node['ruby']['versions'][0]}/bin:#{ENV['PATH']}"
        })
      cwd release_path
      action :run
    end
  end
end
