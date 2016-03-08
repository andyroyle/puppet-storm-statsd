# == Class: storm_statsd::params
class storm_statsd::params {
  $ensure           = 'present'
  $node_module_dir  = '/usr/lib/node_modules'
  $nodejs_bin       = '/usr/bin/node'
  $environment      = []

  $servers          = []
  $statsd           = { }
  $configdir        = '/etc/storm-statsd'
  $logfile          = '/var/log/storm-statsd/storm-statsd.log'

  $manage_service   = true
  $service_ensure   = 'running'
  $service_enable   = true

  $config           = { }

  $dependencies     = undef

  $package_name     = 'storm-statsd'
  $package_source   = undef
  $package_provider = 'npm'

  case $::osfamily {
    'RedHat', 'Amazon': {
      $init_location = '/etc/init.d/storm-statsd'
      $init_mode     = '0755'
      $init_provider = 'redhat'
      $init_script   = 'puppet:///modules/storm_statsd/storm-init-rhel'
    }
    'Debian': {
      $init_location = '/etc/init/storm-statsd.conf'
      $init_mode     = '0644'
      $init_provider = 'upstart'
      $init_script   = 'puppet:///modules/storm_statsd/storm-upstart'
    }
    default: {
      fail('Unsupported OS Family')
    }
  }
}
