unified_mode true

include DockerCookbook::DockerHelpers::Swarm

resource_name :docker_swarm_token
provides :docker_swarm_token

property :token_type, String, name_property: true, equal_to: %w(worker manager)
property :rotate, [true, false], default: false

load_current_value do |_new_resource|
  if swarm_manager?
    cmd = Mixlib::ShellOut.new("docker swarm join-token -q #{new_resourcetoken_type}")
    cmd.run_command
    current_value_does_not_exist! if cmd.error?
  else
    current_value_does_not_exist!
  end
end

action :read do
  if swarm_manager?
    cmd = Mixlib::ShellOut.new(swarm_token_cmd(new_resource.token_type).join(' '))
    cmd.run_command
    raise "Error getting #{new_resource.token_type} token: #{cmd.stderr}" if cmd.error?

    node.run_state['docker_swarm'] ||= {}
    node.run_state['docker_swarm']["#{new_resource.token_type}_token"] = cmd.stdout.strip
  end
end

action :rotate do
  return unless swarm_manager?

  converge_by "rotating #{new_resource.token_type} token" do
    cmd = Mixlib::ShellOut.new("docker swarm join-token --rotate -q #{new_resource.token_type}")
    cmd.run_command
    raise "Error rotating #{new_resource.token_type} token: #{cmd.stderr}" if cmd.error?

    node.run_state['docker_swarm'] ||= {}
    node.run_state['docker_swarm']["#{new_resource.token_type}_token"] = cmd.stdout.strip
  end
end
