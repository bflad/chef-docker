include_recipe 'test::installation_package'
# We need to get the token from the manager node
# In a real environment, you would use a more secure way to distribute the token
ruby_block 'wait for manager' do
  block do
    # Simple wait to ensure manager is up
    sleep 10
  end
  action :run
end

docker_swarm_join 'join swarm' do
  advertise_addr node['docker']['swarm']['join']['advertise_addr']
  listen_addr node['docker']['swarm']['join']['listen_addr']
  manager_ip node['docker']['swarm']['join']['manager_ip']
  token node['docker']['swarm']['join']['token']
  action :join
end
