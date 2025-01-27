control 'docker-swarm-1' do
  impact 1.0
  title 'Docker Swarm Installation'
  desc 'Verify Docker is installed and Swarm mode is active'

  describe command('docker --version') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/Docker version/) }
  end

  describe command('docker info --format "{{ .Swarm.LocalNodeState }}"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/active/) }
  end

  describe command('docker info --format "{{ .Swarm.ControlAvailable }}"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/true/) }
  end
end

control 'docker-swarm-2' do
  impact 1.0
  title 'Docker Swarm Service'
  desc 'Verify the test service is running correctly'

  describe command('docker service ls --format "{{.Name}}"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/web/) }
  end

  describe command('docker service inspect web') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/"Replicas":\s*2/) }

    describe json(content: command('docker service inspect web').stdout) do
      its([0, 'Spec', 'TaskTemplate', 'ContainerSpec', 'Image']) { should match(/^nginx:latest(@sha256:)?/) }
    end
  end

  describe command('docker service ps web --format "{{.CurrentState}}"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/Running/) }
  end
end

control 'docker-swarm-3' do
  impact 1.0
  title 'Docker Swarm Network'
  desc 'Verify swarm networking is configured correctly'

  describe command('docker network ls --filter driver=overlay --format "{{.Name}}"') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/ingress/) }
  end

  describe port(2377) do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
  end
end
