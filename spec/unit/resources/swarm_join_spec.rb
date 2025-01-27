require 'spec_helper'

describe 'docker_swarm_join' do
  step_into :docker_swarm_join
  platform 'ubuntu'

  context 'when joining a swarm' do
    recipe do
      docker_swarm_join 'join' do
        token 'SWMTKN-1-random-token'
        manager_ip '192.168.1.1:2377'
        advertise_addr '192.168.1.2'
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

    it 'runs the swarm join command' do
      expect(Mixlib::ShellOut).to receive(:new).with(/docker swarm join/)
      chef_run
    end
  end

  context 'when already in a swarm' do
    recipe do
      docker_swarm_join 'join' do
        token 'SWMTKN-1-random-token'
        manager_ip '192.168.1.1:2377'
      end
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

    it 'does not run join command if already in swarm' do
      expect(Mixlib::ShellOut).not_to receive(:new).with(/docker swarm join/)
      chef_run
    end
  end
end
