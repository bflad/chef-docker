require 'docker-swarm'

module DockerCookbook
  module DockerHelpers
    module SwarmBase
      def connection_klass
        Docker::Swarm::Connection
      end

      def default_host
        super || 'unix:///var/run/docker.sock'
      end

      def ensure_swarm_available!
        version = Docker.version['ApiVersion'].split('.')
        msg = 'Docker API Version >= 1.12 is required to use Docker Swarm'
        raise msg unless version[0].to_i >= 1 && version[1].to_i >= 12
      end

      def fetch_current_node
        node = Docker::Swarm::Node.new(current_swarm, 'ID' => current_swarm.id)
        node.refresh
        node
      end

      def current_swarm
        @current_swarm ||= Docker::Swarm::Swarm.swarm(connection)
      end

      def current_node
        @current_node ||= fetch_current_node
      end
    end
  end
end
