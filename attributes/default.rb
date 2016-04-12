default['nginx']['default_site_enabled'] = false
default['nginx']['worker_processes'] = 4

default['dafne_online']['app_name'] = 'dafneonline'
default['dafne_online']['deploy_user'] = 'rails'
default['dafne_online']['deploy_base'] = "/home/#{default['dafne_online']['deploy_user']}/apps/#{default['dafne_online']['app_name']}"
default['dafne_online']['document_root'] = "#{default['dafne_online']['deploy_base']}/current/public"
