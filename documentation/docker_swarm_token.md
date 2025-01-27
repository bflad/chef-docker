# docker_swarm_token

The `docker_swarm_token` resource manages Docker Swarm tokens for worker and manager nodes.

## Actions

- `:read` - Read the current token value
- `:rotate` - Rotate the token to a new value
- `:remove` - Remove the token (not typically used)

## Properties

| Property     | Type          | Default       | Description                                                   |
|--------------|---------------|---------------|---------------------------------------------------------------|
| `token_type` | String        | name_property | Type of token to manage. Must be either 'worker' or 'manager' |
| `rotate`     | [true, false] | false         | Whether to rotate the token to a new value                    |

## Examples

### Read a worker token

```ruby
docker_swarm_token 'worker' do
  action :read
end
```

### Rotate a manager token

```ruby
docker_swarm_token 'manager' do
  rotate true
  action :read
end
```

## Notes

- The token values are stored in `node.run_state['docker_swarm']` with keys `worker_token` and `manager_token`
- Token rotation is a security feature that invalidates old tokens
- Only swarm managers can read or rotate tokens
