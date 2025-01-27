# docker_swarm_service

The `docker_swarm_service` resource manages Docker services in a swarm cluster.

## Actions

- `:create` - Create a new service
- `:update` - Update an existing service
- `:delete` - Remove a service

## Properties

| Property          | Type          | Default       | Description                             |
|-------------------|---------------|---------------|-----------------------------------------|
| `service_name`    | String        | name_property | Name of the service                     |
| `image`           | String        | nil           | Docker image to use for the service     |
| `command`         | String, Array | nil           | Command to run in the container         |
| `env`             | Array         | nil           | Environment variables                   |
| `labels`          | Hash          | nil           | Service labels                          |
| `mounts`          | Array         | nil           | Volume mounts                           |
| `networks`        | Array         | nil           | Networks to attach the service to       |
| `ports`           | Array         | nil           | Port mappings                           |
| `replicas`        | Integer       | nil           | Number of replicas to run               |
| `secrets`         | Array         | nil           | Docker secrets to expose to the service |
| `configs`         | Array         | nil           | Docker configs to expose to the service |
| `constraints`     | Array         | nil           | Placement constraints                   |
| `preferences`     | Array         | nil           | Placement preferences                   |
| `endpoint_mode`   | String        | nil           | Endpoint mode ('vip' or 'dnsrr')        |
| `update_config`   | Hash          | nil           | Service update configuration            |
| `rollback_config` | Hash          | nil           | Service rollback configuration          |
| `restart_policy`  | Hash          | nil           | Service restart policy                  |

## Examples

### Create a simple web service

```ruby
docker_swarm_service 'web' do
  image 'nginx:latest'
  ports ['80:80']
  replicas 2
end
```

### Create a service with environment variables and constraints

```ruby
docker_swarm_service 'api' do
  image 'api:v1'
  env ['API_KEY=secret', 'DEBUG=1']
  constraints ['node.role==worker']
  replicas 3
  ports ['8080:8080']
  restart_policy({ 'condition' => 'on-failure', 'max_attempts' => 3 })
end
```

### Update an existing service

```ruby
docker_swarm_service 'web' do
  image 'nginx:1.19'
  replicas 4
  action :update
end
```

### Delete a service

```ruby
docker_swarm_service 'old-service' do
  action :delete
end
```

## Notes

- The node must be a swarm manager to manage services
- Service updates are performed in a rolling fashion by default
- Use `update_config` to fine-tune the update behavior
- Network attachments must be to overlay networks or networks with swarm scope
