module DockerCookbook
  module DockerHelpers
    module Swarm
      def swarm_init_cmd(resource = nil)
        cmd = %w(docker swarm init)
        cmd << "--advertise-addr #{resource.advertise_addr}" if resource && resource.advertise_addr
        cmd << "--listen-addr #{resource.listen_addr}" if resource && resource.listen_addr
        cmd << '--force-new-cluster' if resource && resource.force_new_cluster
        cmd
      end

      def swarm_join_cmd(resource = nil)
        cmd = %w(docker swarm join)
        cmd << "--token #{resource.token}" if resource
        cmd << "--advertise-addr #{resource.advertise_addr}" if resource && resource.advertise_addr
        cmd << "--listen-addr #{resource.listen_addr}" if resource && resource.listen_addr
        cmd << resource.manager_ip if resource
        cmd
      end

      def swarm_leave_cmd(resource = nil)
        cmd = %w(docker swarm leave)
        cmd << '--force' if resource && resource.force
        cmd
      end

      def swarm_token_cmd(token_type)
        raise 'Token type must be worker or manager' unless %w(worker manager).include?(token_type)
        %w(docker swarm join-token -q) << token_type
      end

      def swarm_member?
        cmd = Mixlib::ShellOut.new('docker info --format "{{ .Swarm.LocalNodeState }}"')
        cmd.run_command
        return false if cmd.error?
        cmd.stdout.strip == 'active'
      end

      def swarm_manager?
        return false unless swarm_member?
        cmd = Mixlib::ShellOut.new('docker info --format "{{ .Swarm.ControlAvailable }}"')
        cmd.run_command
        return false if cmd.error?
        cmd.stdout.strip == 'true'
      end

      def swarm_worker?
        swarm_member? && !swarm_manager?
      end

      def service_exists?(name)
        cmd = Mixlib::ShellOut.new("docker service inspect #{name}")
        cmd.run_command
        !cmd.error?
      end
    end
  end
end
