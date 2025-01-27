# docker_swarm_init

The `docker_swarm_init` resource initializes a new Docker swarm cluster.

## Actions

- `:init` - Initialize a new swarm
- `:leave` - Leave the swarm (must be run on a manager node)

## Properties

| Property               | Type          | Default | Description                                   |
|------------------------|---------------|---------|-----------------------------------------------|
| `advertise_addr`       | String        | nil     | Advertised address for other nodes to connect |
| `autolock`             | [true, false] | false   | Enable manager auto-locking                   |
| `cert_expiry`          | String        | nil     | Validity period for node certificates         |
| `data_path_addr`       | String        | nil     | Address for data path traffic                 |
| `dispatcher_heartbeat` | String        | nil     | Dispatcher heartbeat period                   |
| `force_new_cluster`    | [true, false] | false   | Force create a new cluster from current state |
| `listen_addr`          | String        | nil     | Listen address                                |
| `max_snapshots`        | Integer       | nil     | Number of snapshots to keep                   |
| `snapshot_interval`    | Integer       | nil     | Number of log entries between snapshots       |
| `task_history_limit`   | Integer       | nil     | Task history retention limit                  |

## Examples

### Initialize a basic swarm

```ruby
docker_swarm_init 'default' do
  advertise_addr '192.168.1.2'
  listen_addr '0.0.0.0:2377'
end
```

### Initialize a swarm with auto-locking enabled

```ruby
docker_swarm_init 'secure' do
  advertise_addr '192.168.1.2'
  autolock true
  cert_expiry '48h'
end
```

### Leave a swarm

```ruby
docker_swarm_init 'default' do
  action :leave
end
```

## Notes

- Only initialize a swarm on one node - other nodes should join using `docker_swarm_join`
- The node that initializes the swarm becomes the first manager
- Auto-locking requires additional security steps to unlock managers after a restart
- The worker token is automatically stored in node attributes for use by worker nodes
