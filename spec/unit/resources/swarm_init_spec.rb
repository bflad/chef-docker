require 'spec_helper'

describe 'docker_swarm_init' do
  step_into :docker_swarm_init
  platform 'ubuntu'

  context 'when initializing a new swarm' do
    recipe do
      docker_swarm_init 'initialize' do
        advertise_addr '192.168.1.2'
        listen_addr '0.0.0.0:2377'
      end
    end

    before do
      # Mock the shell_out calls directly
      shellout = double('shellout')
      allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
      allow(shellout).to receive(:run_command)
      allow(shellout).to receive(:error?).and_return(false)
      allow(shellout).to receive(:stdout).and_return('')
      allow(shellout).to receive(:stderr).and_return('')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'runs the swarm init command' do
      expect(Mixlib::ShellOut).to receive(:new).with(/docker swarm init/)
      chef_run
    end
  end

  context 'when swarm is already initialized' do
    recipe do
      docker_swarm_init 'initialize'
    end

    before do
      # Mock the shell_out calls directly
      shellout = double('shellout')
      allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
      allow(shellout).to receive(:run_command)
      allow(shellout).to receive(:error?).and_return(false)
      allow(shellout).to receive(:stdout).and_return('active')
      allow(shellout).to receive(:stderr).and_return('')
    end

    it 'does not run init command if already in swarm' do
      expect(Mixlib::ShellOut).not_to receive(:new).with(/docker swarm init/)
      chef_run
    end
  end
end
