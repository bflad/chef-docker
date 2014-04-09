case node['platform']
when 'debian', 'ubuntu'
  include_recipe 'apt'
  package 'apt-transport-https'
  package 'bsdtar'
  sysctl_param 'net.ipv4.ip_forward' do
    value 1
    only_if { node['platform'] == 'debian' && node['docker']['ipv4_forward'] }
  end
end

if node['docker']['exec_driver'] == 'lxc'
  include_recipe 'docker::cgroups'
  include_recipe 'docker::lxc'
end

unless node['docker']['install_type'] == 'package'
  if node['platform'] == 'ubuntu' && Chef::VersionConstraint.new('< 13.10').include?(node['platform_version'])
    include_recipe "docker::#{node['docker']['storage_driver']}" if node['docker']['storage_driver']
  end
  if node['docker']['install_type'] == 'source'
    include_recipe 'golang'
    include_recipe 'git'
  end
end

include_recipe "docker::#{node['docker']['install_type']}"
include_recipe 'docker::group' unless node['docker']['group_members'].empty?
include_recipe "docker::#{node['docker']['init_type']}"
