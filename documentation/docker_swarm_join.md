# docker_swarm_join

The `docker_swarm_join` resource allows a node to join an existing Docker swarm cluster.

## Actions

- `:join` - Join a swarm cluster
- `:leave` - Leave the swarm cluster (--force is always used)

## Properties

| Property         | Type   | Default  | Description                          |
|------------------|--------|----------|--------------------------------------|
| `token`          | String | Required | Swarm join token (worker or manager) |
| `manager_ip`     | String | Required | IP address of a manager node         |
| `advertise_addr` | String | nil      | Advertised address for this node     |
| `listen_addr`    | String | nil      | Listen address for the node          |
| `data_path_addr` | String | nil      | Address for data path traffic        |

## Examples

### Join a node to the swarm

```ruby
docker_swarm_join 'worker' do
  token 'SWMTKN-1-xxxx'
  manager_ip '192.168.1.2'
end
```

### Join with custom network configuration

```ruby
docker_swarm_join 'worker-custom' do
  token 'SWMTKN-1-xxxx'
  manager_ip '192.168.1.2'
  advertise_addr '192.168.1.3'
  listen_addr '0.0.0.0:2377'
end
```

### Leave the swarm

```ruby
docker_swarm_join 'worker' do
  token 'SWMTKN-1-xxxx'
  manager_ip '192.168.1.2'
  action :leave
end
```

## Notes

- The join token can be obtained from a manager node using `docker_swarm_token`
- The default port for swarm communication is 2377
- Use `advertise_addr` when the node has multiple network interfaces
- The `:leave` action will always use the --force flag
- The resource is idempotent and will not try to join if the node is already a swarm member
