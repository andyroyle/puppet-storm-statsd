# puppet-storm_statsd

[![Build Status](https://travis-ci.org/andyroyle/puppet-storm-statsd.png)](https://travis-ci.org/andyroyle/puppet-storm-statsd) [![Puppet Forge](http://img.shields.io/puppetforge/v/andyroyle/storm_statsd.svg?style=flat)](https://forge.puppetlabs.com/andyroyle/storm_statsd)

## Description

This Puppet module will install [storm-statsd](https://github.com/andyroyle/puppet-storm-statsd/) on Debian or RedHat.

## Installation

`puppet module install --modulepath /path/to/puppet/modules andyroyle-storm_statsd`

## Requirements

This module assumes nodejs & npm is installed on the host, but will not do it for you. I recommend using [puppet/nodejs](https://github.com/puppet-community/puppet-nodejs) to set this up.

## Usage
```puppet
    class { 'storm_statsd':
      servers => [
        {
          host     => 'http://my.storm.1.instance.com',
          username => 'user',
          password => 'password',
          tags     => {                     # tags are only supported by influxdb backend
            foo => 'bar'
          },
          prefix   => 'bar.storm.yay' # prefix to apply to the metric name
        }
      ],
      statsd => {
        host     => 'localhost',
        port     => 8125,
        interval => 10, # interval in seconds to send metrics,
        prefix   => 'foo', # global prefix to apply to all metrics,
        debug    => true # print out metrics that are logged (default false)
      }
    }
```

## Testing

```
bundle install
bundle exec librarian-puppet install
vagrant up
```

## Custom Nodejs Environment

Use the `$environment` parameter to add custom environment variables or run scripts in the `/etc/default/storm-statsd` file:

```
class { 'storm-statsd':
  # ...
  environment  => [
    'PATH=/opt/my/path:$PATH',
  ]
}
```

## This looks familiar
Module structure largely copy-pasted from [puppet-statsd](https://github.com/justindowning/puppet-statsd)
