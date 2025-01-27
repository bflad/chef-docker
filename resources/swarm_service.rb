unified_mode true

include DockerCookbook::DockerHelpers::Swarm

resource_name :docker_swarm_service
provides :docker_swarm_service

property :service_name, String, name_property: true
property :image, String, required: true
property :command, [String, Array]
property :replicas, Integer, default: 1
property :env, [Array], default: []
property :labels, [Hash], default: {}
property :mounts, [Array], default: []
property :networks, [Array], default: []
property :ports, [Array], default: []
property :constraints, [Array], default: []
property :secrets, [Array], default: []
property :configs, [Array], default: []
property :restart_policy, Hash, default: { condition: 'any' }

# Health check
property :healthcheck_cmd, String
property :healthcheck_interval, String
property :healthcheck_timeout, String
property :healthcheck_retries, Integer

load_current_value do |new_resource|
  cmd = Mixlib::ShellOut.new("docker service inspect #{new_resource.service_name}")
  cmd.run_command
  if cmd.error?
    current_value_does_not_exist!
  else
    service_info = JSON.parse(cmd.stdout).first
    image service_info['Spec']['TaskTemplate']['ContainerSpec']['Image']
    command service_info['Spec']['TaskTemplate']['ContainerSpec']['Command']
    env service_info['Spec']['TaskTemplate']['ContainerSpec']['Env']
    replicas service_info['Spec']['Mode']['Replicated']['Replicas']
  end
end

action :create do
  return unless swarm_manager?

  converge_if_changed do
    cmd = create_service_cmd(new_resource)

    converge_by "creating service #{new_resource.service_name}" do
      shell_out!(cmd.join(' '))
    end
  end
end

action :update do
  return unless swarm_manager?
  return unless service_exists?(new_resource)

  converge_if_changed do
    cmd = update_service_cmd(new_resource)

    converge_by "updating service #{new_resource.service_name}" do
      shell_out!(cmd.join(' '))
    end
  end
end

action :delete do
  return unless swarm_manager?
  return unless service_exists?(new_resource)

  converge_by "deleting service #{new_resource.service_name}" do
    shell_out!("docker service rm #{new_resource.service_name}")
  end
end

action_class do
  def service_exists?(new_resource)
    cmd = Mixlib::ShellOut.new("docker service inspect #{new_resource.service_name}")
    cmd.run_command
    !cmd.error?
  end

  def create_service_cmd(new_resource)
    cmd = %w(docker service create)
    cmd << "--name #{new_resource.service_name}"
    cmd << "--replicas #{new_resource.replicas}"

    new_resource.env.each { |e| cmd << "--env #{e}" }
    new_resource.labels.each { |k, v| cmd << "--label #{k}=#{v}" }
    new_resource.mounts.each { |m| cmd << "--mount #{m}" }
    new_resource.networks.each { |n| cmd << "--network #{n}" }
    new_resource.ports.each { |p| cmd << "--publish #{p}" }
    new_resource.constraints.each { |c| cmd << "--constraint #{c}" }

    if new_resource.restart_policy
      cmd << "--restart-condition #{new_resource.restart_policy[:condition]}"
      cmd << "--restart-delay #{new_resource.restart_policy[:delay]}" if new_resource.restart_policy[:delay]
      cmd << "--restart-max-attempts #{new_resource.restart_policy[:max_attempts]}" if new_resource.restart_policy[:max_attempts]
      cmd << "--restart-window #{new_resource.restart_policy[:window]}" if new_resource.restart_policy[:window]
    end

    if new_resource.healthcheck_cmd
      cmd << "--health-cmd #{new_resource.healthcheck_cmd}"
      cmd << "--health-interval #{new_resource.healthcheck_interval}" if new_resource.healthcheck_interval
      cmd << "--health-timeout #{new_resource.healthcheck_timeout}" if new_resource.healthcheck_timeout
      cmd << "--health-retries #{new_resource.healthcheck_retries}" if new_resource.healthcheck_retries
    end

    cmd << new_resource.image
    cmd << new_resource.command if new_resource.command
    cmd
  end

  def update_service_cmd(new_resource)
    cmd = %w(docker service update)
    cmd << "--image #{new_resource.image}"
    cmd << "--replicas #{new_resource.replicas}"
    cmd << new_resource.service_name
    cmd
  end
end
