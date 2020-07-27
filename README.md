# VlcProxy

[![Gem Version](https://badge.fury.io/rb/vlc_proxy.svg)](https://badge.fury.io/rb/vlc_proxy)
[![Build Status](https://travis-ci.org/zsyed91/vlc_proxy.svg?branch=master)](https://travis-ci.org/zsyed91/vlc_proxy)


VLC exposes an optional [http server](https://wiki.videolan.org/Documentation:Modules/http_intf/) for remote commands to be called against the
running instance of VLC. This can be configured to listen on localhost only and
uses HTTP basic auth for authentication.

The purpose of this gem is to allow programmatic access using ruby against this
http server. Possible use cases are scripts to automate VLC, expose automation
services to your VLC instance, gather information on your running VLC instance,
control VLC programmatically etc.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vlc_proxy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vlc_proxy

## Usage

At the top of your application or script load the library:

```ruby
require 'vlc_proxy
```

### Client Usage - Basic Example

First create the connection object by giving it both the hostname that VLC is
running on along with the password set for basic auth. The default port is `8080`
and the default scheme is `http`.

```ruby
# Create the connection

connection = VlcProxy::Connection.new(hostname, password)

# Create the client
client = VlcProxy::Client.new(connection)

puts client.current_state.inspect
```

### Client Usage - Advanced Example

If you configure the HTTP server not to use the default port and scheme, you
can pass this into the connection object as optional inputs to override the defaults.

```ruby
# Create the connection

port = 8090
connection = VlcProxy::Connection.new(hostname, password, port)

# Create the client
client = VlcProxy::Client.new(connection)

if client.connection.connected?
  puts 'Hello VLC'
else
  puts 'Failed to connect to VLC'
end
```

### Methods available

After creating the client, there are multiple methods exposed to interact with
the VLC instance. The basic example is to call current state, but we can also
make VLC take actions directly available through the UI.

- current_state
- pause_playlist
- start_playlist
- stop_playlist
- next_item
- previous_item
- toggle_repeat
- toggle_loop
- toggle_random
- toggle_fullscren
- increase_volume(amount)
- decrease_volume(amount)
- skip_forward(amount_in_seconds)
- skip_backward(amount_in_seconds)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zsyed91/vlc_proxy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the VlcProxy project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/zsyed91/vlc_proxy/blob/master/CODE_OF_CONDUCT.md).
