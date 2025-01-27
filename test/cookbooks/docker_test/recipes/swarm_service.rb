# Wait a bit to ensure the swarm is ready
ruby_block 'wait for swarm initialization' do
  block do
    sleep 10
  end
  action :run
end

docker_swarm_service node['docker']['swarm']['service']['name'] do
  image node['docker']['swarm']['service']['image']
  ports node['docker']['swarm']['service']['publish']
  replicas node['docker']['swarm']['service']['replicas']
  action :create
end

# Add a test to verify the service is running
ruby_block 'verify service' do
  block do
    20.times do # try for about 1 minute
      cmd = Mixlib::ShellOut.new('docker service ls')
      cmd.run_command
      break if cmd.stdout =~ /#{node['docker']['swarm']['service']['name']}/
      sleep 3
    end
  end
  action :run
end
