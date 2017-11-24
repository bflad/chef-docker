begin
  gem 'docker-api', '= 1.33.6'
rescue LoadError
  unless defined?(ChefSpec)
    run_context = Chef::RunContext.new(Chef::Node.new, {}, Chef::EventDispatch::Dispatcher.new)

    require 'chef/resource/chef_gem'

    docker = Chef::Resource::ChefGem.new('docker-api', run_context)
    docker.version '= 1.33.6'
    docker.run_action(:install)
  end
end

begin
  gem 'docker-swarm-sdk',
      github: 'elthariel/docker_swarm_sdk',
      branch: 'fix/swarm_init_typo'
rescue LoadError
  unless defined?(ChefSpec)
    run_context = Chef::RunContext.new(Chef::Node.new, {}, Chef::EventDispatch::Dispatcher.new)

    require 'chef/resource/chef_gem'

    docker = Chef::Resource::ChefGem.new('docker-swarm-sdk', run_context)
    docker.version '= 1.2.9'
    docker.run_action(:install)
  end
end
