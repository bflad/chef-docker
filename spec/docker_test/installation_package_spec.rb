require 'spec_helper'

describe 'docker_test::installation_package' do
  platform 'ubuntu'
  step_into :docker_installation_package
  cached(:subject) { chef_run }

  context 'Ubuntu: testing default action, default properties' do
    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end

    it do
      expect(chef_run).to add_apt_repository('docker').with(
        components: %w(stable),
        uri: 'https://download.docker.com/linux/ubuntu',
        arch: 'amd64',
        key: %w(https://download.docker.com/linux/ubuntu/gpg)
      )
    end
  end

  context 'Ubuntu (aarch64): testing default action, default properties' do
    automatic_attributes['kernel']['machine'] = 'aarch64'
    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end

    it do
      expect(chef_run).to add_apt_repository('docker').with(
        components: %w(stable),
        uri: 'https://download.docker.com/linux/ubuntu',
        arch: 'arm64',
        key: %w(https://download.docker.com/linux/ubuntu/gpg)
      )
    end
  end

  context 'Ubuntu (ppc64le): testing default action, default properties' do
    automatic_attributes['kernel']['machine'] = 'ppc64le'
    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end

    it do
      expect(chef_run).to add_apt_repository('docker').with(
        components: %w(stable),
        uri: 'https://download.docker.com/linux/ubuntu',
        arch: 'ppc64el',
        key: %w(https://download.docker.com/linux/ubuntu/gpg)
      )
    end
  end

  context 'CentOS: testing default action, default properties' do
    platform 'centos'
    cached(:subject) { chef_run }
    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end
    it do
      expect(chef_run).to create_yum_repository('docker').with(
        baseurl: 'https://download.docker.com/linux/centos/8/x86_64/stable',
        gpgkey: 'https://download.docker.com/linux/centos/gpg',
        description: 'Docker Stable repository',
        gpgcheck: true,
        enabled: true
      )
    end
  end

  context 'CentOS 9: testing default action, default properties' do
    platform 'centos-stream', '9'
    cached(:subject) { chef_run }

    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end
    it do
      expect(chef_run).to create_yum_repository('docker').with(
        baseurl: 'https://download.docker.com/linux/centos/9/x86_64/stable',
        gpgkey: 'https://download.docker.com/linux/centos/gpg',
        description: 'Docker Stable repository',
        gpgcheck: true,
        enabled: true
      )
    end
  end

  context 'RHEL (s390x): testing default action, default properties' do
    platform 'redhat', '8'
    cached(:subject) { chef_run }
    automatic_attributes['kernel']['machine'] = 's390x'

    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end
    it do
      expect(chef_run).to create_yum_repository('docker').with(
        baseurl: 'https://download.docker.com/linux/rhel/8/s390x/stable',
        gpgkey: 'https://download.docker.com/linux/rhel/gpg',
        description: 'Docker Stable repository',
        gpgcheck: true,
        enabled: true
      )
    end
  end

  context 'RHEL 8: testing default action, default properties' do
    platform 'redhat', '8'
    cached(:subject) { chef_run }

    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end
    it do
      expect(chef_run).to create_yum_repository('docker').with(
        baseurl: 'https://download.docker.com/linux/rhel/8/x86_64/stable',
        gpgkey: 'https://download.docker.com/linux/rhel/gpg',
        description: 'Docker Stable repository',
        gpgcheck: true,
        enabled: true
      )
    end
  end

  context 'RHEL 9: testing default action, default properties' do
    platform 'redhat', '9'
    cached(:subject) { chef_run }

    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end
    it do
      expect(chef_run).to create_yum_repository('docker').with(
        baseurl: 'https://download.docker.com/linux/rhel/9/x86_64/stable',
        gpgkey: 'https://download.docker.com/linux/rhel/gpg',
        description: 'Docker Stable repository',
        gpgcheck: true,
        enabled: true
      )
    end
  end

  context 'Oracle 7: testing default action, default properties' do
    platform 'oracle', '7'
    cached(:subject) { chef_run }
    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end
    it do
      expect(chef_run).to create_yum_repository('docker').with(
        baseurl: 'https://download.docker.com/linux/centos/7/x86_64/stable',
        gpgkey: 'https://download.docker.com/linux/centos/gpg',
        description: 'Docker Stable repository',
        gpgcheck: true,
        enabled: true
      )
    end
  end

  context 'Oracle 8: testing default action, default properties' do
    platform 'oracle', '8'
    cached(:subject) { chef_run }
    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end
    it do
      expect(chef_run).to create_yum_repository('docker').with(
        baseurl: 'https://download.docker.com/linux/rhel/8/x86_64/stable',
        gpgkey: 'https://download.docker.com/linux/rhel/gpg',
        description: 'Docker Stable repository',
        gpgcheck: true,
        enabled: true
      )
    end
  end

  context 'Oracle 9: testing default action, default properties' do
    platform 'oracle', '9'
    cached(:subject) { chef_run }
    it 'installs docker' do
      expect(chef_run).to create_docker_installation_package('default')
    end
    it do
      expect(chef_run).to create_yum_repository('docker').with(
        baseurl: 'https://download.docker.com/linux/rhel/9/x86_64/stable',
        gpgkey: 'https://download.docker.com/linux/rhel/gpg',
        description: 'Docker Stable repository',
        gpgcheck: true,
        enabled: true
      )
    end
  end

  # Coverage of all recent docker versions
  # To ensure test coverage and backwards compatibility
  # With the frequent changes in package naming convention
  # List generated from
  # https://download.docker.com/linux/ubuntu/dists/#{distro}/stable/binary-amd64/Packages

  context 'version strings for Ubuntu 20.04' do
    platform 'ubuntu', '20.04'
    cached(:subject) { chef_run }

    [
      { docker_version: '19.03.10', expected: '5:19.03.10~3-0~ubuntu-focal' },
      { docker_version: '20.10.7', expected: '5:20.10.7~3-0~ubuntu-focal' },
    ].each do |suite|
      it 'generates the correct version string ubuntu focal' do
        custom_resource = chef_run.docker_installation_package('default')
        actual = custom_resource.version_string(suite[:docker_version])
        expect(actual).to eq(suite[:expected])
      end
    end
  end

  # context 'version strings for Ubuntu 18.04' do
  #   platform 'ubuntu', '18.04'
  #   cached(:subject) { chef_run }

  #   [
  #     { docker_version: '18.03.1', expected: '18.03.1~ce~3-0~ubuntu' },
  #     { docker_version: '18.06.0', expected: '18.06.0~ce~3-0~ubuntu' },
  #     { docker_version: '18.06.1', expected: '18.06.1~ce~3-0~ubuntu' },
  #     { docker_version: '18.09.0', expected: '5:18.09.0~3-0~ubuntu-bionic' },
  #     { docker_version: '19.03.5', expected: '5:19.03.5~3-0~ubuntu-bionic' },
  #     { docker_version: '20.10.7', expected: '5:20.10.7~3-0~ubuntu-bionic' },
  #   ].each do |suite|
  #     it 'generates the correct version string ubuntu bionic' do
  #       custom_resource = chef_run.docker_installation_package('default')
  #       actual = custom_resource.version_string(suite[:docker_version])
  #       expect(actual).to eq(suite[:expected])
  #     end
  #   end
  # end

  # context 'version strings for Debian 9' do
  #   platform 'debian', '9'
  #   cached(:subject) { chef_run }
  #   [
  #     {  docker_version: '17.06.0', expected: '17.06.0~ce-0~debian' },
  #     {  docker_version: '17.06.1', expected: '17.06.1~ce-0~debian' },
  #     {  docker_version: '17.09.0', expected: '17.09.0~ce-0~debian' },
  #     {  docker_version: '17.09.1', expected: '17.09.1~ce-0~debian' },
  #     {  docker_version: '17.12.0', expected: '17.12.0~ce-0~debian' },
  #     {  docker_version: '17.12.1', expected: '17.12.1~ce-0~debian' },
  #     {  docker_version: '18.03.0', expected: '18.03.0~ce-0~debian' },
  #     {  docker_version: '18.03.1', expected: '18.03.1~ce-0~debian' },
  #     {  docker_version: '18.06.0', expected: '18.06.0~ce~3-0~debian' },
  #     {  docker_version: '18.06.1', expected: '18.06.1~ce~3-0~debian' },
  #     {  docker_version: '18.09.0', expected: '5:18.09.0~3-0~debian-stretch' },
  #     {  docker_version: '19.03.5', expected: '5:19.03.5~3-0~debian-stretch' },
  #   ].each do |suite|
  #     it 'generates the correct version string debian stretch' do
  #       custom_resource = chef_run.docker_installation_package('default')
  #       actual = custom_resource.version_string(suite[:docker_version])
  #       expect(actual).to eq(suite[:expected])
  #     end
  #   end
  # end

  # context 'version strings for Debian 10' do
  #   platform 'debian', '10'
  #   cached(:subject) { chef_run }
  #   [
  #     {  docker_version: '18.03.0', expected: '18.03.0~ce-0~debian' },
  #     {  docker_version: '18.03.1', expected: '18.03.1~ce-0~debian' },
  #     {  docker_version: '18.06.0', expected: '18.06.0~ce~3-0~debian' },
  #     {  docker_version: '18.06.1', expected: '18.06.1~ce~3-0~debian' },
  #     {  docker_version: '18.06.2', expected: '18.06.2~ce~3-0~debian' },
  #     {  docker_version: '18.06.3', expected: '18.06.3~ce~3-0~debian' },
  #     {  docker_version: '19.03.5', expected: '5:19.03.5~3-0~debian-buster' },
  #     {  docker_version: '18.09.0', expected: '5:18.09.0~3-0~debian-buster' },
  #     {  docker_version: '18.09.9', expected: '5:18.09.9~3-0~debian-buster' },
  #     {  docker_version: '19.03.0', expected: '5:19.03.0~3-0~debian-buster' },
  #     {  docker_version: '19.03.5', expected: '5:19.03.5~3-0~debian-buster' },
  #     {  docker_version: '20.10.7', expected: '5:20.10.7~3-0~debian-buster' },
  #   ].each do |suite|
  #     it 'generates the correct version string debian buster' do
  #       custom_resource = chef_run.docker_installation_package('default')
  #       actual = custom_resource.version_string(suite[:docker_version])
  #       expect(actual).to eq(suite[:expected])
  #     end
  #   end
  # end

  # context 'version strings for Debian 11' do
  #   platform 'debian', '11'
  #   cached(:subject) { chef_run }
  #   [
  #     {  docker_version: '20.10.11', expected: '5:20.10.11~3-0~debian-bullseye' },
  #   ].each do |suite|
  #     it 'generates the correct version string debian bullseye' do
  #       custom_resource = chef_run.docker_installation_package('default')
  #       actual = custom_resource.version_string(suite[:docker_version])
  #       expect(actual).to eq(suite[:expected])
  #     end
  #   end
  # end
end
