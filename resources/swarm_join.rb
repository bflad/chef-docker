unified_mode true

include DockerCookbook::DockerHelpers::Swarm

resource_name :docker_swarm_join
provides :docker_swarm_join

property :token, String, required: true
property :manager_ip, String, required: true
property :advertise_addr, String
property :listen_addr, String
property :data_path_addr, String

action :join do
  return if swarm_member?

  converge_by 'joining docker swarm' do
    cmd = Mixlib::ShellOut.new(swarm_join_cmd.join(' '))
    cmd.run_command
    if cmd.error?
      raise "Failed to join swarm: #{cmd.stderr}"
    end
  end
end

action :leave do
  return unless swarm_member?

  converge_by 'leaving docker swarm' do
    cmd = Mixlib::ShellOut.new('docker swarm leave --force')
    cmd.run_command
    if cmd.error?
      raise "Failed to leave swarm: #{cmd.stderr}"
    end
  end
end
