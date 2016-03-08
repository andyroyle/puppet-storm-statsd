# == Class: storm_statsd::config
class storm_statsd::config (
  $servers                           = $storm_statsd::servers,
  $statsd                            = $storm_statsd::statsd,
  $configdir                         = $storm_statsd::configdir,
  $config                            = $storm_statsd::config,

  $environment = $storm_statsd::environment,
  $nodejs_bin  = $storm_statsd::nodejs_bin,
  $stormjs     = "${storm_statsd::node_module_dir}/storm-statsd/storm.js",
  $logfile     = $storm_statsd::logfile,
) {

  file { $configdir:
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }->
  file { "${configdir}/storm.json":
    content => template('storm_statsd/storm.json.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }->
  file { "${configdir}/statsd.json":
    content => template('storm_statsd/statsd.json.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }

  file { $storm_statsd::init_location:
    source => $storm_statsd::init_script,
    mode   => $storm_statsd::init_mode,
    owner  => 'root',
    group  => 'root',
  }

  file {  '/etc/default/storm-statsd':
    content => template('storm_statsd/storm-defaults.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { '/var/log/storm-statsd':
    ensure => directory,
    mode   => '0755',
    owner  => 'nobody',
    group  => 'root',
  }

  file { '/usr/local/sbin/storm-statsd':
    source => 'puppet:///modules/storm_statsd/storm-wrapper',
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

}
