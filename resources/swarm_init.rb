unified_mode true

include DockerCookbook::DockerHelpers::Swarm

resource_name :docker_swarm_init
provides :docker_swarm_init

property :advertise_addr, String
property :listen_addr, String
property :force_new_cluster, [true, false], default: false
property :autolock, [true, false], default: false

action :init do
  return if swarm_member?

  converge_by 'initializing docker swarm' do
    cmd = Mixlib::ShellOut.new(swarm_init_cmd(new_resource).join(' '))
    cmd.run_command
    if cmd.error?
      raise "Failed to initialize swarm: #{cmd.stderr}"
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
