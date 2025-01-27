# docker Cookbook CHANGELOG

This file is used to list changes made in each version of the docker cookbook.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

- Add Docker Swarm support
  New resources:
  - docker_swarm_init
  - docker_swarm_join
  - docker_swarm_service
  - docker_swarm_token

## 11.8.4 - *2024-12-11*

- Update resources overview
- Update documentation for `docker_container` resource
- Update documentation for `docker_service` resource
- Update documentation for `docker_exec` resource
- Update documentation for `docker_installation_package` resource
- Update documentation for `docker_installation_script` resource
- Update documentation for `docker_installation_tarball` resource
- Update documentation for `docker_service_manager_execute` resource
- Update documentation for `docker_service_manager_systemd` resource
- Update documentation for `docker_volume_prune` resource

## 11.8.2 - *2024-12-11*

- Enhance tmpfs support for containers
  - Added support for array format in tmpfs property
  - Improved documentation with examples
  - Added test coverage for tmpfs functionality

## 11.8.1 - *2024-12-11*

- Fix issue with container network mode causing unnecessary redeployment when using `container:<name>` format
  - Added network mode normalization to handle container IDs consistently
  - Prevents container recreation when only the container ID format changes

## 11.8.0 - *2024-12-11*

- Add volume_prune resource

## 11.7.0 - *2024-12-11*

- Added GPU support for the `docker_container` resource

## 11.6.0 - *2024-12-03*

- Add opts for ip6tables

## 11.5.0 - *2024-08-03*

- Add `none` as an option to `service_manager` to allow using the system defaults
- Switch to running vagrant+virtualbox on Ubuntu via nested virtualization for smoke tests
- Fix package installation tests

## 11.4.1 - *2024-07-16*

- Fix `version_string` for Debian Bookworm

## 11.4.0 - *2024-07-15*

- `docker_installation_package` support for Ubuntu v24.04 (noble)

## 11.3.7 - *2024-07-09*

- Bump `docker-api` dependency to `>= 2.3` to fix [upstream bug #586](https://github.com/upserve/docker-api/issues/586)

## 11.3.6 - *2024-07-08*

- Version bump to force a release

## 11.3.5 - *2024-07-08*

- Temporary version in for `excon` gem due to v0.111.0 introducing breaking changes with the `docker-api` gem. To be fixed [upstream](https://github.com/upserve/docker-api/issues/586)

## 11.3.2 - *2024-02-21*

- Add site_url property to docker_installation_package resource

## 11.3.0 - *2023-10-12*

- fix the generation of the docker version string to install on ubuntu jammy

## 11.2.6 - *2023-10-10*

- Standardise files with files in sous-chefs/repo-management
- Various MDL fixes

## 11.2.1 - *2023-08-18*

- Fix breaking change introduced by #1253 (Add CgroupnsMode from Docker API as option)

## 11.2.0 - *2023-08-10*

- added cgroup_ns option to container resource with default private

## 11.0.1 - *2023-06-01*

- Only pass common resource properties of the `docker_service`-resource to
  the specific service manager resources.

## 11.0.0 - *2023-05-29*

- Update to work on Chef 18 in unified mode, fixes #1222 [@b-dean](https://github.com/b-dean)

    The following resources are now custom resources:

    - `docker_installation`
    - `docker_installation_package`
    - `docker_installation_script`
    - `docker_installation_tarball`
    - `docker_service`
    - `docker_service_base`
    - `docker_service_manager`
    - `docker_service_manager_execute`
    - `docker_service_manager_systemd`

    This means their classes are no longer in the `DockerCookbook` module.

## 10.4.9 - *2023-05-16*

- Update sous-chefs/.github action to v2.0.4

## 10.4.8 - *2023-04-24*

- Update sous-chefs/.github action to v2.0.2

## 10.4.7 - *2023-04-20*

- Standardise files with files in sous-chefs/repo-management

## 10.4.4 - *2023-02-20*

- Standardise files with files in sous-chefs/repo-management

## 10.4.3 - *2023-02-15*

- Standardise files with files in sous-chefs/repo-management

## 10.4.2 - *2023-02-14*

- [skip ci] Fix yaml

## 10.4.1 - *2023-02-03*

- Fixed "Can't start a simple container" in #1226 [@urlund](https://github.com/urlund)

## 10.4.0 - *2023-02-03*

- Set a ceiling of Chef 17 as Chef 18 is broken due to #1222
- Fix various CI issues

## 10.3.0 - *2022-12-13*

- `docker_installation_package` support for ubuntu 22.04

## 10.2.5 - *2022-12-05*

- Standardise files with files in sous-chefs/repo-management

## 10.2.4 - *2022-11-03*

- Update readme.md syntax, add link

## 10.2.3 - *2022-11-03*

- Update [CHANGELOG.md](CHANGELOG.md) to fix MarkDownLint rules

## 10.2.2 - *2022-10-10*

- Fix arguments to `generate_json` in `docker_image_prune` resource

## 10.2.1 - *2022-10-07*

- Sort container `volume_binds` to prevent erroneous container re-deploys

## 10.2.0 - *2022-08-19*

- Don't set container swappiness with cgroupv2

## 10.1.8 - *2022-04-20*

- Standardise files with files in sous-chefs/repo-management

## 10.1.7 - *2022-02-04*

- Remove delivery and move to calling RSpec directly via a reusable workflow
- Update tested platforms

## 10.1.6 - *2022-01-05*

- Add debian 11 support

## 10.1.5 - *2021-12-20*

- Fix `generate_json` not accepting a variable number of arguments

## 10.1.4 - *2021-12-05*

- Fix raise when using mixed address families with a network

## 10.1.3 - *2021-12-01*

- Update to tarball checksums to 20.10.11 and 19.03.15
- Update to using version 20.10.11 for testing suites

## 10.1.2 - *2021-11-16*

- Fix group resource for `docker_installation_tarball` library in #1205 [@benoitjpnet](https://github.com/benoitjpnet)

## 10.1.1 - *2021-11-03*

- Add CentOS Stream 8 to CI pipeline

## 10.1.0 - *2021-10-20*

- Move the `docker_image_prune` library to a custom resource

## 10.0.1 - *2021-10-20*

- Remove old refernces to services managers that no longer exist

## 10.0.0 - *2021-10-20*

- Remove the sysvinit Docker Service managers
   - Platforms that supported these service managers are now EOL

## 9.11.0 - *2021-10-20*

- Remove the `docker_network` library as it is no longer used
- Move the `docker_registry` library to a custom resource

## 9.10.0 - *2021-10-19*

- Move the `docker_tag` library to a custom resource

## 9.9.0 - *2021-10-15*

- Fix unwanted changes to `/lib/systemd/system/* files`

## 9.8.0 - *2021-10-14*

- Stop the socket when stopping the service with systemd

## 9.7.0 - *2021-09-21*

- Move the `docker_image` library to a custom resource

## 9.6.1 - *2021-09-20*

- Update exec resource to use `partial/_base`

## 9.6.0 - *2021-09-16*

- Move the `docker_plugin` library to a custom resource

## 9.5.0 - *2021-09-16*

- Move the `docker_network` library to a custom resource

## 9.4.0 - *2021-09-16*

- Add `ip`and `ip6` properties to `docker_network`

## 9.3.1 - *2021-09-15*

- Move the Docker log properties to a partial

## 9.3.0 - *2021-09-15*

- Update and sync log drivers list for `docker_service_manager` and `docker_container`

## 9.2.0 - *2021-09-15*

- Move the `docker_exec` library to a custom resource

## 9.1.0 - *2021-09-15*

- Move the `docker_container` resource to a custom resource

## 9.0.0 - *2021-09-15*

- Move the `docker_volume` resources to a custom resource
- Add the base partial for all future resources
- Require Chef 16+ for resource partial support

## 8.3.0 - *2021-09-13*

- Remove Ubuntu 16.04 from the GitHub Actions test matrix
- Add amazonlinux-2 to the test matrix

## 8.2.4 - *2021-09-09*

- Ensure `docker_container` :health_check is idempotent

## 8.2.3 - *2021-09-08*

- Fix private registries credentials handling and public registries

## 8.2.2 - *2021-08-27*

- Use new `action_class` instead of `declare_action_class.class_eval` for helper methods in resources

## 8.2.1 - *2021-08-26*

- Ensure `docker_container :user` is idempotent

## 8.2.0 - *2021-08-26*

- Ensure `docker_container :health_check` is idempotent

## 8.1.0 - *2021-08-25*

- Remove Ubuntu 16.04 support now it's end of life

## 8.0.1 - *2021-08-25*

- fix markdown links check

## 8.0.0 - *2021-08-25*

- Remove upstart docker service manage
   - We don't officialy support any distros that use upstart anymore

## 7.7.8 - *2021-08-25

- Fixes image prune filters to match updated format

## 7.7.7 - *2021-08-24*

- Update port syntax for `docker_container`

## 7.7.6 - *2021-08-24*

- [920] Properly document the devices syntax

## 7.7.5 - *2021-08-24*

- Disable installation-script-main suite on Debian 9 due to lack of upstream support

## 7.7.4 - *2021-08-24*

- Standardise files with files in sous-chefs/repo-management

## 7.7.3 - *2021-07-17*

- Ensure `docker_image :load` is idempotent

## 7.7.2 - *2021-07-01*

- Fix `installed_docker_version` method on ppc64le which appends `v` to the version

## 7.7.1 - *2021-06-30*

- Fix package installation on RHEL s390x architecture

## 7.7.0 - *2021-02-26*

- Add `buildargs` property to `docker_image` resource

## 7.6.1 - *2021-01-11*

- Fixed `reload_signal` and `cpus` bug for `docker_container` in #1090 [@urlund](https://github.com/urlund)

## 7.6.0 - *2021-01-06*

- Support for loki-docker driver logging plugin

## 7.5.0 - *2021-01-04*

- Update to use 20.10 by default
- Update tarball for 19.03 to 19.03.14

## 7.4.1 - *2021-01-01*

- Fix the codeowners to use the correct group

## 7.4.0 - *2020-12-04*

- Support `local`  option for the `log_driver` properties of `docker_service` and `docker_container` resources

## 7.3.0 - *2020-12-02*

- Updates the `registry_mirror` option of `docker_service` to be either a string or array. This way multiple mirrors can be configured

## 7.2.2 (2020-11-05)

- Remove creates guard for extracting tarball which prevents upgrades

## 7.2.1 (2020-11-03)

- Fix issue with `default-ip-addr` in systemd

## 7.2.0 (2020-10-26)

- Add `cpus` options to `docker_container`

## 7.1.0 (2020-10-23)

### Changed

- Sous Chefs Adoption
- Update Changelog to Sous Chefs
- Update to use Sous Chefs GH workflow
- Disable installation-script-experimental
- Update README to sous-chefs
- Update metadata.rb to Sous Chefs
- Update tarball version to 19.03.13
- Update tarball suite tests
- Update tarball checksums to latest versions

### Fixed

- Cookstyle fixes
- Update and fix ChefSpec tests
- Yamllint fixes
- MDL Fixes
- Loosen docker-api gem to allow >= 1.34, < 3.0 (resolves #1135)
- Update test recipes/tests so they can work with Cinc
- Ensure `docker` group exists for tarball installation
- Enable containerd systemd unit if binary exists

### Added

- Add testing for CentOS 8
- Add testing for Ubuntu 20.04
- Add `docker_install_method` helper to automate install method
- Add `container.service` unit for tarball installation method

### Removed

- Disable broken tests and `resources` suite

## 7.0.0 (2020-08-31)

### Breaking Change

The 7.0 release includes a breaking change to package installs with version specified. Before this change RHEL based systems allowed specifying any valid version string (19, 19.03, 19.03.8) and an * was added automatically to package name for specified version installation. New change specifies docker-ce package name and uses package resource version option to specify version. The version option default has been removed and thus will default to the lastest version. If version option is specified it'll lock the package to that version. Debian family machines are unaffected by the change. With this change we will not need to constantly release new versions of the cookbook for new releases of Docker.

## 6.0.3 (2020-06-15)

- Removed default value for properties working_dir and memory_swap. - [@antima-gupta](https://github.com/antima-gupta)
- Updated memory_swap default value 0 to nil - [@antima-gupta](https://github.com/antima-gupta)
- Fix for docker_exec does not check the return code of the command it runs - [@kapilchouhan99](https://github.com/kapilchouhan99)
- Add provides in addition to resource_name to all resources - [@tas50](https://github.com/tas50)

## 6.0.2 (2020-06-02)

- Standardise files with files in chef-cookbooks/repo-management - [@xorimabot](https://github.com/xorimabot)
- Resolved deprecations to provide Chef Infra Client 16 compatibility - [@xorimabot](https://github.com/xorimabot)
   - resolved cookstyle error: libraries/docker_container.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_exec.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_image.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_image_prune.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_installation_package.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_installation_tarball.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_network.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_plugin.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_registry.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_service_manager_execute.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_tag.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
   - resolved cookstyle error: libraries/docker_volume.rb:3:5 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`

## 6.0.1 (2020-05-26)

- Allow configuring reload signal #1089 - [@scalp42](https://github.com/scalp42)
- Update docker_image doc to fix escaping typo - [@pgilad](https://github.com/pgilad)
- Fix for env_file breaks on Chef 16 - [@kapilchouhan99](https://github.com/kapilchouhan99)

## 6.0.0 (2020-04-28)

- Require Chef Infra Client 15+ to fix issues with package versions on RHEL / Fedora since Chef Infra Client 15 reworked how yum_package performed and let us now pass in human readable versions to be installed- [@tas50](https://github.com/tas50)

## 5.0.0 (2020-04-28)

- Fix missing reference to new_resource.restart_policy - [@petracvv](https://github.com/petracvv)
- Add testing with Github Actions - [@tas50](https://github.com/tas50)
- Added debian 10 support
- Add 'live_restore' property to 'docker_service'
- Use new_resource to read attribute - [@dud225](https://github.com/dud225)
- set default ipc_mode to shareable to prevent redeploying containers on each run - [@dheerajd-msys](https://github.com/dheerajd-msys)
- Cookstyle fix - [@tas50](https://github.com/tas50)
- Remove legacy Amazon Linux 201x support. This cookbook now requires Amazon Linux 2 - [@tas50](https://github.com/tas50)
- Remove support for EOL Ubuntu distros 14.04 and 17.10 - [@tas50](https://github.com/tas50)
- install_package: Remove support for Docker 17.03 and earlier - [@tas50](https://github.com/tas50)
- Require Chef Infra Client 13 or later - [@tas50](https://github.com/tas50)
- Simplify the platform detection code - [@tas50](https://github.com/tas50)

## 4.12.0 (2020-01-03)

- Include support for other architectures using upstream repo - [@ramereth](https://github.com/ramereth)

## 4.11.0 (2019-12-16)

- Update format of docker tarball filenames > 18.06.3 - [@smcavallo](https://github.com/smcavallo)
- Rework integration and unit tests to get everything green again - [@smcavallo](https://github.com/smcavallo)
- Update the systemd unit file - [@smcavallo](https://github.com/smcavallo)
- Remove the legacy foodcritic comments that aren't needed since we use cookstyle - [@tas50](https://github.com/tas50)

## 4.10.0 (2019-11-18)

- Cookstyle: Don't set allowed_actions in the resource - [@tas50](https://github.com/tas50)
- update to the latest version of docker (for security reasons) - [@smcavallo](https://github.com/smcavallo)
- fixing the default docker version in the kitchen tests - [@smcavallo](https://github.com/smcavallo)

## 4.9.3 (2019-08-14)

- fixes issue #1061, docker_volume 'driver' and 'opts' don't work

## 4.9.2 (2019-02-15)

- Support setting shared memory size.

## 4.9.1 (2019-02-01)

- added systemd_socket_opts for additional configuration of the systemd socket file

## 4.9.0 (2018-12-17)

- Add support for windows - [@smcavallo](https://github.com/smcavallo)
- Expand ChefSpec testing - [@smcavallo](https://github.com/smcavallo)
- Fix for when HealthCheck is used - [@smcavallo](https://github.com/smcavallo)

## 4.8.0 (2018-12-09)

- Fix issues with network_mode in docker_container - [@smcavallo](https://github.com/smcavallo)
- Add support for container health_check options - [@smcavallo](https://github.com/smcavallo)
- Add new docker_image_prune resource - [@smcavallo](https://github.com/smcavallo)

## 4.7.0 (2018-12-05)

- Added 17.03 support on RHEL 7. Thanks @smcavallo
- Added 18.09 support. Thanks @smcavallo

## 4.6.8 (2018-11-27)

- add missing new_resource reference that prevented docker_container's reload action from running

## 4.6.7 (2018-10-10)

- Add :default_address_pool property to docker_service
- Import docker.com repository gpg key via HTTPS directly from docker to avoid timeouts with Ubuntu's key registry

## 4.6.6 (7.3.0 - *2020-12-02*)

- :default_ip_address_pool property added to configure default address pool for networks created by Docker.

## 4.6.5 (2018-09-04)

- package names changed again. looks like they swapped xenial and bionic name schema.

## 4.6.4 (2018-08-29)

- xenial 18.03 contains the new test version format

## 4.6.3 (2018-08-23)

- refactor version_string

## 4.6.2 (2018-08-23)

- Use different version string on .deb packages

## 4.6.1 (2018-08-21)

- Include setup_docker_repo in docker_service and allow old docker-ce versions for centos

## 4.6.0 (2018-08-19)

- Bump docker version to 18.06.0

## 4.5.0 (2018-08-16)

- sets the default log_level for the systemd docker service back to nil
- change require relative to library path
- docker_execute -> docker_exec
- Loosen up the requirement on docker-api gem
- Add new docker_plugin resource

## 4.4.1 (2018-07-23)

- Adding tests for docker_container detach == false (container is attached)
- Add new_resource and current_resource objects as context for methods when telling a container to wait (when detach is false)

## 4.4.0 (2018-07-17)

- docker service :log_level property converted to String.
- Use new package versioning scheme for Ubuntu bionic
- Bump the docker version everywhere

## 4.3.0 (2018-06-19)

- Remove the zesty? helper
- Initial support for Debian Buster (10)
- Bump the package default to 18.03.0
- Remove old integration tests
- Update package specs to pass on Amazon Linux

## 4.2.0 (2018-04-09)

- Initial support for Chef 14
- Remove unused api_version helper
- Support additional sysv RHEL like platforms by using platform_family
- Added oom_kill_disable and oom_score_adj support to docker_container
- ENV returns nil if the variable isn't found
- Remove the TLS default helpers
- Move coerce_labels into docker_container where its used
- Add desired_state false to a few more properties
- If the ENV values are nil don't use them to build busted defaults for TLS
- Remove a giant pile of Chef 12-isms
- Kill off ArrayType and NonEmptyArray types
- Don't require docker all over the place
- Kill the ShellCommand type
- Fix undefined method `v' for DockerContainer
- Make to_shellwords idempotent in DockerContainer
- Fix(Chef14): Use property_is_set with new_resource
- Use try-restart for systemd & retry start one time

## 4.1.1 (2018-03-11)

- Move to_snake_case to the container resource where it's used
- Reduce the number of coerce helpers in the the container resource
- Remove the Boolean type and instead just use TrueClass,FalseClass
- Use an actual integer in the memory_swappiness test since after reworking the coerce helpers we're requiring what we always stated we required here

## 4.1.0 (2018-03-10)

- Remove required from the name property. This resolves Foodcritic warnings in Foodcritic 13
- Resolve a pile of Chef 14 deprecation warnings in the container and images resources
- Remove support for Ubuntu 17.04 from the installation_package resource
- Moved all the helper libraries into the resources themselves. This is part 1 of the work to get these resources ready for inclusion in Chef 14
- Removed the version logic from installation_package when on Amazon Linux. Since we don't setup the repo we only have a single version available to us and we should just install that version. This resolves the constant need to update the hardcoded version in the cookbook every time Amazon releases a new Docker version.

## 4.0.2 (2018-03-05)

- Flag registry password property as sensitive in docker_registry resource

## 4.0.1 (2018-02-07)

- allow labels to have colons in the value

## 4.0.0 (2018-01-15)

### Breaking Changes

- Default to Docker 17.12.0
- Remove previously deprecated support for Debian 7 / CentOS 6\. Currently supported released of Docker do not run on these platforms.
- Removed support for the EOL Docker 1.12.3
- Removed the ChefSpec matchers which are no longer needed with ChefDK 2.X
- Remove the broken legacy binary installation resource. This was only used by very old EOL docker releases
- By default setup the apt/yum repos in the package install resource so that out of the box there's no need for additional cookbooks. If you would like to manage your own docker repos or other internal repos this may be disabled by property. Due to this change the cookbook now requires Chef 12.15+

### Other Changes

- Greatly expand Travis CI testing of the cookbook and use new InSpec resources for Docker instead of shelling out
- Add support for Ubuntu 17.10
- Update Fedora support for new DNF support in Chef
- Minor correctness and formatting updates to the readme
- load internal and ipv6 status for existing docker_network resources
- Update Amazon Linux to default to 17.09.1, which is the current version in their repos
- Fix the remove action in docker_installation_script
- Replace deprecated graph with data_root. Graph will now silently map to data_root
- Pass --host instead of -H in docker_service for clarity
- Make sure tar is installed to decompress the tarball in the docker_installation_tarball resource
- Update the download path for Docker CE to unbreak docker_installation_tarball
- Allow specifying channels in the docker_installation_tarball resource so you can install non-stable releases

- [#22](https://github.com/sous-chefs/docker/issues/22)
- [#24](https://github.com/sous-chefs/docker/issues/24)
- [#25](https://github.com/sous-chefs/docker/issues/25)
- [#26](https://github.com/sous-chefs/docker/issues/26)
- [#27](https://github.com/sous-chefs/docker/issues/27)
- [#28](https://github.com/sous-chefs/docker/issues/28)
- [#30](https://github.com/sous-chefs/docker/issues/30)
- [#31](https://github.com/sous-chefs/docker/issues/31)
- [#35](https://github.com/sous-chefs/docker/issues/35)
- [#37](https://github.com/sous-chefs/docker/issues/37)
- [#38](https://github.com/sous-chefs/docker/issues/38)
- [#39](https://github.com/sous-chefs/docker/issues/39)
- [#42](https://github.com/sous-chefs/docker/issues/42)
- [#43](https://github.com/sous-chefs/docker/issues/43)
- [#44](https://github.com/sous-chefs/docker/issues/44)
- [#46](https://github.com/sous-chefs/docker/issues/46)
- [#47](https://github.com/sous-chefs/docker/issues/47)
- [#48](https://github.com/sous-chefs/docker/issues/48)
- [#49](https://github.com/sous-chefs/docker/issues/49)
- [#51](https://github.com/sous-chefs/docker/issues/51)
- [#52](https://github.com/sous-chefs/docker/issues/52)
- [#55](https://github.com/sous-chefs/docker/issues/55)
- [#56](https://github.com/sous-chefs/docker/issues/56)
- [#57](https://github.com/sous-chefs/docker/issues/57)
- [#58](https://github.com/sous-chefs/docker/issues/58)
- [#59](https://github.com/sous-chefs/docker/issues/59)
- [#60](https://github.com/sous-chefs/docker/issues/60)
- [#62](https://github.com/sous-chefs/docker/issues/62)
- [#63](https://github.com/sous-chefs/docker/issues/63)
- [#64](https://github.com/sous-chefs/docker/issues/64)
- [#65](https://github.com/sous-chefs/docker/issues/65)
- [#67](https://github.com/sous-chefs/docker/issues/67)
- [#68](https://github.com/sous-chefs/docker/issues/68)
- [#72](https://github.com/sous-chefs/docker/issues/72)
- [#77](https://github.com/sous-chefs/docker/issues/77)
- [#78](https://github.com/sous-chefs/docker/issues/78)
- [#80](https://github.com/sous-chefs/docker/issues/80)
- [#81](https://github.com/sous-chefs/docker/issues/81)
- [#82](https://github.com/sous-chefs/docker/issues/82)
- [#83](https://github.com/sous-chefs/docker/issues/83)
- [#84](https://github.com/sous-chefs/docker/issues/84)
- [#85](https://github.com/sous-chefs/docker/issues/85)
- [#86](https://github.com/sous-chefs/docker/issues/86)
- [#88](https://github.com/sous-chefs/docker/issues/88)
- [#89](https://github.com/sous-chefs/docker/issues/89)
- [#90](https://github.com/sous-chefs/docker/issues/90)
- [#91](https://github.com/sous-chefs/docker/issues/91)
- [#98](https://github.com/sous-chefs/docker/issues/98)
- [#101](https://github.com/sous-chefs/docker/issues/101)
- [#103](https://github.com/sous-chefs/docker/issues/103)
- [#104](https://github.com/sous-chefs/docker/issues/104)
- [#105](https://github.com/sous-chefs/docker/issues/105)
- [#106](https://github.com/sous-chefs/docker/issues/106)
- [#107](https://github.com/sous-chefs/docker/issues/107)
- [#108](https://github.com/sous-chefs/docker/issues/108)
- [#109](https://github.com/sous-chefs/docker/issues/109)
- [#110](https://github.com/sous-chefs/docker/issues/110)
- [#111](https://github.com/sous-chefs/docker/issues/111)
- [#112](https://github.com/sous-chefs/docker/issues/112)
- [#113](https://github.com/sous-chefs/docker/issues/113)
- [#114](https://github.com/sous-chefs/docker/issues/114)
- [#115](https://github.com/sous-chefs/docker/issues/115)
- [#116](https://github.com/sous-chefs/docker/issues/116)
- [#117](https://github.com/sous-chefs/docker/issues/117)
- [#118](https://github.com/sous-chefs/docker/issues/118)
- [#119](https://github.com/sous-chefs/docker/issues/119)
- [#120](https://github.com/sous-chefs/docker/issues/120)
- [#123](https://github.com/sous-chefs/docker/issues/123)
- [#124](https://github.com/sous-chefs/docker/issues/124)
- [#125](https://github.com/sous-chefs/docker/issues/125)
- [#126](https://github.com/sous-chefs/docker/issues/126)
- [#127](https://github.com/sous-chefs/docker/issues/127)
- [#128](https://github.com/sous-chefs/docker/issues/128)
- [#132](https://github.com/sous-chefs/docker/issues/132)
- [#133](https://github.com/sous-chefs/docker/issues/133)
- [#134](https://github.com/sous-chefs/docker/issues/134)
- [#137](https://github.com/sous-chefs/docker/issues/137)
- [#138](https://github.com/sous-chefs/docker/issues/138)
- [#139](https://github.com/sous-chefs/docker/issues/139)
- [#141](https://github.com/sous-chefs/docker/issues/141)
- [#142](https://github.com/sous-chefs/docker/issues/142)
- [#144](https://github.com/sous-chefs/docker/issues/144)
- [#147](https://github.com/sous-chefs/docker/issues/147)
- [#149](https://github.com/sous-chefs/docker/issues/149)
- [#150](https://github.com/sous-chefs/docker/issues/150)
- [#152](https://github.com/sous-chefs/docker/issues/152)
- [#153](https://github.com/sous-chefs/docker/issues/153)
- [#154](https://github.com/sous-chefs/docker/issues/154)
- [#156](https://github.com/sous-chefs/docker/issues/156)
- [#157](https://github.com/sous-chefs/docker/issues/157)
- [#158](https://github.com/sous-chefs/docker/issues/158)
- [#160](https://github.com/sous-chefs/docker/issues/160)
- [#161](https://github.com/sous-chefs/docker/issues/161)
- [#164](https://github.com/sous-chefs/docker/issues/164)
- [#165](https://github.com/sous-chefs/docker/issues/165)
- [#166](https://github.com/sous-chefs/docker/issues/166)
- [#168](https://github.com/sous-chefs/docker/issues/168)
- [#169](https://github.com/sous-chefs/docker/issues/169)
- [#171](https://github.com/sous-chefs/docker/issues/171)
- [#172](https://github.com/sous-chefs/docker/issues/172)
- [#173](https://github.com/sous-chefs/docker/issues/173)
- [#175](https://github.com/sous-chefs/docker/issues/175)
- [#176](https://github.com/sous-chefs/docker/issues/176)
- [#181](https://github.com/sous-chefs/docker/issues/181)
- [#185](https://github.com/sous-chefs/docker/issues/185)
- [#188](https://github.com/sous-chefs/docker/issues/188)
- [#192](https://github.com/sous-chefs/docker/issues/192)
- [#196](https://github.com/sous-chefs/docker/issues/196)
- [#200](https://github.com/sous-chefs/docker/issues/200)
- [#202](https://github.com/sous-chefs/docker/issues/202)
- [#203](https://github.com/sous-chefs/docker/issues/203)
- [#205](https://github.com/sous-chefs/docker/issues/205)
- [#206](https://github.com/sous-chefs/docker/issues/206)
- [#208](https://github.com/sous-chefs/docker/issues/208)
- [#217](https://github.com/sous-chefs/docker/issues/217)
- [#219](https://github.com/sous-chefs/docker/issues/219)
- [#220](https://github.com/sous-chefs/docker/issues/220)
- [#221](https://github.com/sous-chefs/docker/issues/221)
- [#223](https://github.com/sous-chefs/docker/issues/223)
- [#224](https://github.com/sous-chefs/docker/issues/224)
- [#232](https://github.com/sous-chefs/docker/issues/232)
- [#233](https://github.com/sous-chefs/docker/issues/233)
- [#234](https://github.com/sous-chefs/docker/issues/234)
- [#237](https://github.com/sous-chefs/docker/issues/237)
- [#238](https://github.com/sous-chefs/docker/issues/238)
- [#239](https://github.com/sous-chefs/docker/issues/239)
- [#240](https://github.com/sous-chefs/docker/issues/240)
- [#242](https://github.com/sous-chefs/docker/issues/242)
- [#244](https://github.com/sous-chefs/docker/issues/244)
- [#245](https://github.com/sous-chefs/docker/issues/245)
- [#246](https://github.com/sous-chefs/docker/issues/246)
- [#250](https://github.com/sous-chefs/docker/issues/250)
- [#258](https://github.com/sous-chefs/docker/issues/258)
- [#259](https://github.com/sous-chefs/docker/issues/259)
- [#260](https://github.com/sous-chefs/docker/issues/260)
- [#263](https://github.com/sous-chefs/docker/issues/263)
- [#264](https://github.com/sous-chefs/docker/issues/264)
- [#265](https://github.com/sous-chefs/docker/issues/265)
- [#266](https://github.com/sous-chefs/docker/issues/266)
- [#267](https://github.com/sous-chefs/docker/issues/267)
- [#268](https://github.com/sous-chefs/docker/issues/268)
- [#269](https://github.com/sous-chefs/docker/issues/269)
- [#276](https://github.com/sous-chefs/docker/issues/276)
- [#279](https://github.com/sous-chefs/docker/issues/279)
- [#280](https://github.com/sous-chefs/docker/issues/280)
- [#281](https://github.com/sous-chefs/docker/issues/281)
- [#284](https://github.com/sous-chefs/docker/issues/284)
- [#285](https://github.com/sous-chefs/docker/issues/285)
- [#287](https://github.com/sous-chefs/docker/issues/287)
- [#289](https://github.com/sous-chefs/docker/issues/289)
- [#292](https://github.com/sous-chefs/docker/issues/292)
- [#296](https://github.com/sous-chefs/docker/issues/296)
- [#297](https://github.com/sous-chefs/docker/issues/297)
- [#298](https://github.com/sous-chefs/docker/issues/298)
