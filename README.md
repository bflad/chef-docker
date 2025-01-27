# Docker Cookbook

[![CI State](https://github.com/sous-chefs/docker/workflows/ci/badge.svg)](https://github.com/sous-chefs/docker/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

The Docker Cookbook provides resources for installing docker as well as building, managing, and running docker containers.

## Scope

This cookbook is concerned with the [Docker](http://docker.io) container engine as distributed by Docker, Inc. It does not address Docker ecosystem tooling or prerequisite technology such as cgroups or aufs.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

- Network accessible web server hosting the docker binary.
- SELinux permissive/disabled if CentOS [Docker Issue #15498](https://github.com/docker/docker/issues/15498)

## Platform Support

- Amazon Linux 2
- Debian 9/10/11
- Fedora
- Ubuntu 18.04/20.04/22.04
- CentOS 7/8

## Cookbook Dependencies

This cookbook automatically sets up the upstream Docker package repositories. If you would like to use your own repositories this functionality can be disabled and you can instead setup the repos yourself with yum_repository/apt_repository resources or the [chef-apt-docker](https://supermarket.chef.io/cookbooks/chef-apt-docker) / [chef-yum-docker](https://supermarket.chef.io/cookbooks/chef-yum-docker) cookbooks.

## Docker Group

If you are not using the official docker repositories you may run into issues with the docker group being different. RHEL is a known issue that defaults to using `dockerroot` for the service group. Add the `group` property to the `docker_service`.

```ruby
docker_service 'default' do
  group 'dockerroot'
  action [:create, :start]
end
```

## Usage

- Add `depends 'docker'` to your cookbook's metadata.rb
- Use the resources shipped in cookbook in a recipe, the same way you'd use core Chef resources (file, template, directory, package, etc).

```ruby
docker_service 'default' do
  action [:create, :start]
end

docker_image 'busybox' do
  action :pull
end

docker_container 'an-echo-server' do
  repo 'busybox'
  port '1234:1234'
  command "nc -ll -p 1234 -e /bin/cat"
end
```

## Test Cookbooks as Examples

The cookbooks run by test-kitchen make excellent usage examples.

Those recipes are found at `test/cookbooks/docker_test`.

## Resources Overview

- [docker_service](documentation/docker_service.md): composite resource that uses docker_installation and docker_service_manager
- [docker_container](documentation/docker_container.md): container operations
- [docker_exec](documentation/docker_exec.md): execute commands inside running containers
- [docker_image](documentation/docker_image.md): image/repository operations
- [docker_image_prune](documentation/docker_image_prune.md): remove unused docker images
- [docker_installation_package](documentation/docker_installation_package.md): install Docker via package 'docker-ce'
- [docker_installation_script](documentation/docker_installation_script.md): install Docker via curl | bash
- [docker_installation_tarball](documentation/docker_installation_tarball.md): install Docker from a tarball
- [docker_network](documentation/docker_network.md): network operations
- [docker_plugin](documentation/docker_plugin.md): plugin operations
- [docker_registry](documentation/docker_registry.md): registry operations
- [docker_service_manager_execute](documentation/docker_service_manager_execute.md): manage docker daemon with Chef
- [docker_service_manager_systemd](documentation/docker_service_manager_systemd.md): manage docker daemon with systemd unit files
- [docker_tag](documentation/docker_tag.md): image tagging operations
- [docker_volume](documentation/docker_volume.md): volume operations
- [docker_volume_prune](documentation/docker_volume_prune.md): remove unused docker volumes
- [docker_swarm_init](documentation/docker_swarm_init.md): initialize a new Docker swarm cluster
- [docker_swarm_join](documentation/docker_swarm_join.md): join a node to a Docker swarm cluster
- [docker_swarm_service](documentation/docker_swarm_service.md): manage Docker swarm services
- [docker_swarm_token](documentation/docker_swarm_token.md): manage Docker swarm tokens

## Getting Started

Here's a quick example of pulling the latest image and running a container with exposed ports.

```ruby
# Pull latest image
docker_image 'nginx' do
  tag 'latest'
  action :pull
  notifies :redeploy, 'docker_container[my_nginx]'
end

# Run container mapping containers port 80 to the host's port 80
docker_container 'my_nginx' do
  repo 'nginx'
  tag 'latest'
  port [ '80:80' ]
  host_name 'www'
  domain_name 'computers.biz'
  env 'FOO=bar'
  volumes [ '/some/local/files/:/etc/nginx/conf.d' ]
end
```

You might run a private registry and multiple Docker hosts.

```ruby
# Login to private registry
docker_registry 'https://registry.computers.biz/' do
  username 'shipper'
  password 'iloveshipping'
  email 'shipper@computers.biz'
end

# Pull tagged image
docker_image 'registry.computers.biz:443/my_project/my_container' do
  tag 'latest'
  action :pull
  host 'tcp://host-1.computers.biz:2376'
end

# Run container
docker_container 'crowsnest' do
  repo 'registry.computers.biz:443/my_project/my_container'
  tag 'latest'
  host 'tcp://host-2.computers.biz:2376'
  tls_verify true
  tls_ca_cert "/path/to/ca.pem"
  tls_client_cert "/path/to/cert.pem"
  tls_client_key "/path/to/key.pem"
  action :run
end
```

You can manipulate Docker volumes and networks

```ruby
docker_network 'my_network' do
  subnet '10.9.8.0/24'
  gateway '10.9.8.1'
end

docker_volume 'my_volume' do
  action :create
end

docker_container 'my_container' do
  repo 'alpine'
  tag '3.1'
  command "nc -ll -p 1234 -e /bin/cat"
  volumes 'my_volume:/my_data'
  network_mode 'my_network'
  action :run
end
```

See full documentation for each resource and action below for more information.

## Resources

## docker_installation

The `docker_installation` resource auto-selects one of the below resources with the provider resolution system.

### Example

```ruby
docker_installation 'default'
```

## docker_installation_tarball

The `docker_installation_tarball` resource copies the precompiled Go binary tarball onto the disk. It should not be used in production, especially with devicemapper.

### Example

```ruby
docker_installation_tarball 'default' do
  version '1.11.0'
  source 'https://my.computers.biz/dist/docker.tgz'
  checksum '97a3f5924b0b831a310efa8bf0a4c91956cd6387c4a8667d27e2b2dd3da67e4d'
  action :create
end
```

### Properties

- `version` - The desired version of docker to fetch.
- `channel` - The docker channel to fetch the tarball from. Default: stable
- `source` - Path to network accessible Docker binary tarball. Ignores version when set.
- `checksum` - SHA-256 checksum of the tarball file.

## docker_installation_script

The `docker_installation_script` resource runs the script hosted by Docker, Inc at <http://get.docker.com>. It configures package repositories and installs a dynamically compiled binary.

### Example

```ruby
docker_installation_script 'default' do
  repo 'main'
  script_url 'https://my.computers.biz/dist/scripts/docker.sh'
  action :create
end
```

### Properties

- `repo` - One of 'main', 'test', or 'experimental'. Used to calculate script_url in its absence. Defaults to 'main'
- `script_url` - 'URL of script to pipe into /bin/sh as root.

## docker_installation_package

The `docker_installation_package` resource uses the system package manager to install Docker. It relies on the pre-configuration of the system's package repositories. The `chef-yum-docker` and `chef-apt-docker` Supermarket cookbooks can be used to use Docker's own repositories.

**_This is the recommended production installation method._**

### Example

```ruby
docker_installation_package 'default' do
  version '20.10.11'
  action :create
  package_options %q|--force-yes -o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-all'| # if Ubuntu for example
end
```

### Properties

- `version` - Used to calculate package_version string. This needs to be the complete version (19.03.8).
- `package_version` - Manually specify the package version string
- `package_name` - Name of package to install. Defaults to 'docker-ce'
- `package_options` - Manually specify additional options, like apt-get directives for example
- `setup_docker_repo` - Setup the download.docker.com repo. If you would like to manage the repo yourself so you can use an internal repo then set this to false. default: true on all platforms except Amazon Linux.
- `repo_channel` - The channel of docker to setup from download.docker.com. Only used if `setup_docker_repo` is true. default: 'stable'

## docker_service_manager

The `docker_service_manager` resource auto-selects a strategy from the `docker_service_manager_*` group of resources based on platform and version. The `docker_service` family share a common set of properties.

### Example

```ruby
docker_service_manager 'default' do
  action :start
end
```

## docker_service_manager_execute

### Example

```ruby
docker_service_manager_execute 'default' do
  action :start
end
```

## docker_service_manager_systemd

### Example

```ruby
docker_service_manager_systemd 'default' do
  host ['unix:///var/run/docker.sock', 'tcp://127.0.0.1:2376']
  tls_verify true
  tls_ca_cert "/path/to/ca.pem"
  tls_server_cert "/path/to/server.pem"
  tls_server_key "/path/to/server-key.pem"
  tls_client_cert "/path/to/cert.pem"
  tls_client_key "/path/to/key.pem"
  systemd_opts ["TasksMax=infinity","MountFlags=private"]
  systemd_socket_opts ["Accept=yes"]
  action :start
end
```

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
