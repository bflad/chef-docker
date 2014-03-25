case node['platform']
when 'debian', 'ubuntu'
  include_recipe 'apt'
  package 'apt-transport-https'
  package 'bsdtar'
  sysctl_param 'net.ipv4.ip_forward' do
    value 1
    only_if { node['platform'] == 'debian' }
  end
end

include_recipe 'docker::cgroups' if node['docker']['exec_driver'] == 'lxc'

unless node['docker']['install_type'] == 'package'
  if node['platform'] == 'ubuntu' && Chef::VersionConstraint.new('< 13.10').include?(node['platform_version'])
    include_recipe "docker::#{node['docker']['storage_driver']}" if node['docker']['storage_driver']
  end
  include_recipe 'docker::lxc' if node['docker']['exec_driver'] == 'lxc'
  if node['docker']['install_type'] == 'source'
    include_recipe 'golang'
    include_recipe 'git'
  end
end

# We must be on Docker >= 0.9.0 to specify an exec_driver
node.set['docker']['use_exec_driver'] = false
if node['docker']['exec_driver']
  if node['docker']['binary']['version'] == 'latest' || Chef::VersionConstraint.new('>= 0.9.0').include?(node['docker']['binary']['version'])
    node.set['docker']['use_exec_driver'] = true
  end
end

include_recipe "docker::#{node['docker']['install_type']}"
include_recipe 'docker::group' unless node['docker']['group_members'].empty?
include_recipe "docker::#{node['docker']['init_type']}"
