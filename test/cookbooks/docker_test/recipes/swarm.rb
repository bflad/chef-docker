include_recipe 'docker_test::installation_package'

docker_swarm_init 'initialize swarm' do
  advertise_addr node['docker']['swarm']['init']['advertise_addr']
  listen_addr node['docker']['swarm']['init']['listen_addr']
  action :init
end

# Read or rotate the worker token
docker_swarm_token 'worker' do
  rotate node['docker']['swarm']['rotate_token'] if node['docker']['swarm']['rotate_token']
  action node['docker']['swarm']['rotate_token'] ? :rotate : :read
  notifies :create, 'ruby_block[save_token]', :immediately
end

# Save the token to a node attribute for use by workers
ruby_block 'save_token' do
  block do
    node.override['docker']['swarm']['tokens'] ||= {}
    node.override['docker']['swarm']['tokens']['worker'] = node.run_state['docker_swarm']['worker_token']
  end
  action :nothing
end
