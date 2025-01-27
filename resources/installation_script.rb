unified_mode true
use 'partial/_base'

resource_name :docker_installation_script
provides :docker_installation_script

provides :docker_installation, os: 'linux'

property :repo, %w(main test experimental), default: 'main', desired_state: false
property :script_url, String, default: lazy { default_script_url }, desired_state: false

default_action :create

#########################
# property helper methods
#########################

def default_script_url
  "https://#{repo == 'main' ? 'get' : 'test'}.docker.com/"
end

#########
# Actions
#########

action :create do
  package 'curl' do
    options '--allowerasing'
    not_if 'rpm -q curl-minimal'
  end

  execute 'install docker' do
    command "curl -sSL #{new_resource.script_url} | sh"
    creates '/usr/bin/docker'
  end
end

action :delete do
  package %w(docker-ce docker-engine) do
    action :remove
  end
end
