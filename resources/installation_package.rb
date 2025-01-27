unified_mode true
use 'partial/_base'

resource_name :docker_installation_package
provides :docker_installation_package

property :setup_docker_repo, [true, false], default: true, desired_state: false
property :repo_channel, String, default: 'stable'
property :package_name, String, default: 'docker-ce', desired_state: false
property :package_version, String, desired_state: false
property :version, String, desired_state: false
property :package_options, String, desired_state: false
property :site_url, String, default: 'download.docker.com'

def el7?
  return true if platform_family?('rhel') && node['platform_version'].to_i == 7
  false
end

def el8?
  return true if platform_family?('rhel') && node['platform_version'].to_i == 8
  false
end

def fedora?
  return true if platform?('fedora')
  false
end

def debuntu?
  return true if platform_family?('debian')
  false
end

def debian?
  return true if platform?('debian')
  false
end

def ubuntu?
  return true if platform?('ubuntu')
  false
end

def stretch?
  return true if platform?('debian') && node['platform_version'].to_i == 9
  false
end

def buster?
  return true if platform?('debian') && node['platform_version'].to_i == 10
  false
end

def bullseye?
  return true if platform?('debian') && node['platform_version'].to_i == 11
  false
end

def bookworm?
  return true if platform?('debian') && node['platform_version'].to_i == 12
  false
end

def bionic?
  return true if platform?('ubuntu') && node['platform_version'] == '18.04'
  false
end

def focal?
  return true if platform?('ubuntu') && node['platform_version'] == '20.04'
  false
end

def jammy?
  return true if platform?('ubuntu') && node['platform_version'] == '22.04'
  false
end

def noble?
  return true if platform?('ubuntu') && node['platform_version'] == '24.04'
  false
end

# https://github.com/chef/chef/issues/4103
def version_string(v)
  return if v.nil?
  codename = if stretch? # deb 9
               'stretch'
             elsif buster? # deb 10
               'buster'
             elsif bullseye? # deb 11
               'bullseye'
             elsif bookworm? # deb 12
               'bookworm'
             elsif bionic? # ubuntu 18.04
               'bionic'
             elsif focal? # ubuntu 20.04
               'focal'
             elsif jammy? # ubuntu 22.04
               'jammy'
             elsif noble? # ubuntu 24.04
               'noble'
             end

  # https://github.com/seemethere/docker-ce-packaging/blob/9ba8e36e8588ea75209d813558c8065844c953a0/deb/gen-deb-ver#L16-L20
  test_version = '3'

  if v.to_f < 18.06 && !bionic?
    return "#{v}~ce-0~debian" if debian?
    return "#{v}~ce-0~ubuntu" if ubuntu?
  elsif v.to_f >= 23.0 && ubuntu?
    "5:#{v}-1~ubuntu.#{node['platform_version']}~#{codename}"
  elsif v.to_f >= 18.09 && debuntu?
    return "5:#{v}~#{test_version}-0~debian-#{codename}" if debian?
    return "5:#{v}~#{test_version}-0~ubuntu-#{codename}" if ubuntu?
  else
    return "#{v}~ce~#{test_version}-0~debian" if debian?
    return "#{v}~ce~#{test_version}-0~ubuntu" if ubuntu?
    v
  end
end

action :create do
  if new_resource.setup_docker_repo
    if platform_family?('rhel', 'fedora')
      arch = node['kernel']['machine']
      platform =
        if platform?('fedora')
          'fedora'
          # s390x is only available under rhel platform
        elsif platform?('redhat', 'oracle') && (arch == 's390x' || !el7?)
          'rhel'
          # use rhel for all el8 since CentOS 8 is dead
        elsif el8? && !platform?('centos')
          'rhel'
        else
          'centos'
        end

      yum_repository 'docker' do
        baseurl "https://#{new_resource.site_url}/linux/#{platform}/#{node['platform_version'].to_i}/#{arch}/#{new_resource.repo_channel}"
        gpgkey "https://#{new_resource.site_url}/linux/#{platform}/gpg"
        description "Docker #{new_resource.repo_channel.capitalize} repository"
        gpgcheck true
        enabled true
      end
    elsif platform_family?('debian')
      deb_arch =
        case node['kernel']['machine']
        when 'x86_64'
          'amd64'
        when 'aarch64'
          'arm64'
        when 'armv7l'
          'armhf'
        when 'ppc64le'
          'ppc64el'
        else
          node['kernel']['machine']
        end

      package 'apt-transport-https'

      apt_repository 'docker' do
        components Array(new_resource.repo_channel)
        uri "https://#{new_resource.site_url}/linux/#{node['platform']}"
        arch deb_arch
        key "https://#{new_resource.site_url}/linux/#{node['platform']}/gpg"
        action :add
      end

      apt_update 'docker'
    else
      Chef::Log.warn("Cannot setup the Docker repo for platform #{node['platform']}. Skipping.")
    end
  end

  version = new_resource.package_version || version_string(new_resource.version)

  package new_resource.package_name do
    version version
    options new_resource.package_options
    action :install
  end
end

action :delete do
  package new_resource.package_name do
    action :remove
  end
end
