# outline_vpn_api

Ruby API wrapper for Outline VPN Server https://getoutline.org/
It provides a simple interface to manage and retrieve information about VPN keys, metrics, and other related functionalities.

## Installation

Ensure you have the required gems installed:

```bash
gem install outline_vpn_api
```

## Usage

### Initialization

To start using the client, initialize it with the API URL:

```ruby
client = OutlineVpnApi.new('YOUR_API_URL')
```

### Methods

#### `keys_list`

Fetches a list of all keys:

```ruby
keys = client.keys_list
```

#### `transferred_data_by_id`

Fetches the transferred data metrics:

```ruby
data = client.transferred_data_by_id
```

#### `create_key`

Creates a new key:

```ruby
new_key = client.create_key
```

#### `set_limit(key_id, limit)`

Sets a data limit for a specific key:

```ruby
client.set_limit('KEY_ID', LIMIT_IN_BYTES)
```

#### `rename_key(key_id, name)`

Renames a specific key:

```ruby
client.rename_key('KEY_ID', 'NEW_NAME')
```

#### `delete_key(key_id)`

Deletes a specific key:

```ruby
client.delete_key('KEY_ID')
```

## Dependencies

- `httparty`: Used for making HTTP requests.
- `json`: Used for parsing JSON responses.

## Contributing

If you'd like to contribute to this project, please submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
