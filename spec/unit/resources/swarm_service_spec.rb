# require 'spec_helper'

# describe 'docker_swarm_service' do
#   step_into :docker_swarm_service
#   platform 'ubuntu'

#   context 'when creating a service' do
#     recipe do
#       docker_swarm_service 'nginx' do
#         image 'nginx:latest'
#         replicas 2
#         ports %w(80:80)
#       end
#     end

#     before do
#       # Mock swarm status
#       allow_any_instance_of(Chef::Resource).to receive(:shell_out).with('docker info --format "{{ .Swarm.LocalNodeState }}"').and_return(
#         double(error?: false, stdout: "active\n")
#       )
#       allow_any_instance_of(Chef::Resource).to receive(:shell_out).with('docker info --format "{{ .Swarm.ControlAvailable }}"').and_return(
#         double(error?: false, stdout: "true\n")
#       )

#       # Mock service inspection
#       allow_any_instance_of(Chef::Resource).to receive(:shell_out).with('docker service inspect nginx').and_return(
#         double(error?: true, stdout: '', stderr: 'Error: no such service: nginx')
#       )

#       # Mock service creation
#       allow_any_instance_of(Chef::Resource).to receive(:shell_out).with(/docker service create/).and_return(
#         double(error?: false, stdout: '')
#       )
#     end

#     it 'converges successfully' do
#       expect { chef_run }.to_not raise_error
#     end
#   end

#   context 'when not a swarm manager' do
#     recipe do
#       docker_swarm_service 'nginx' do
#         image 'nginx:latest'
#         replicas 2
#         ports %w(80:80)
#       end
#     end

#     before do
#       # Mock swarm status - member but not manager
#       allow_any_instance_of(Chef::Resource).to receive(:shell_out).with('docker info --format "{{ .Swarm.LocalNodeState }}"').and_return(
#         double(error?: false, stdout: "active\n")
#       )
#       allow_any_instance_of(Chef::Resource).to receive(:shell_out).with('docker info --format "{{ .Swarm.ControlAvailable }}"').and_return(
#         double(error?: false, stdout: "false\n")
#       )

#       # Mock service inspection
#       allow_any_instance_of(Chef::Resource).to receive(:shell_out).with('docker service inspect nginx').and_return(
#         double(error?: true, stdout: '', stderr: 'Error: no such service: nginx')
#       )
#     end

#     it 'does not create the service' do
#       expect(chef_run).to_not run_execute('create service nginx')
#     end
#   end
# end
