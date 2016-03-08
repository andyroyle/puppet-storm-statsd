# == Class storm_statsd
class storm_statsd (
  $ensure           = $storm_statsd::params::ensure,
  $node_module_dir  = $storm_statsd::params::node_module_dir,
  $nodejs_bin       = $storm_statsd::params::nodejs_bin,
  $environment      = $storm_statsd::params::environment,

  $servers          = $storm_statsd::params::servers,
  $statsd           = $storm_statsd::params::statsd,
  $configdir        = $storm_statsd::params::configdir,
  $logfile          = $storm_statsd::params::logfile,

  $manage_service   = $storm_statsd::params::manage_service,
  $service_ensure   = $storm_statsd::params::service_ensure,
  $service_enable   = $storm_statsd::params::service_enable,

  $config           = $storm_statsd::params::config,

  $init_location    = $storm_statsd::params::init_location,
  $init_mode        = $storm_statsd::params::init_mode,
  $init_provider    = $storm_statsd::params::init_provider,
  $init_script      = $storm_statsd::params::init_script,

  $package_name     = $storm_statsd::params::package_name,
  $package_source   = $storm_statsd::params::package_source,
  $package_provider = $storm_statsd::params::package_provider,

  $dependencies     = $storm_statsd::params::dependencies,
) inherits storm_statsd::params {

  if $dependencies {
    $dependencies -> Class['storm_statsd']
  }

  class { 'storm_statsd::config': }

  package { 'storm_statsd':
    ensure   => $ensure,
    name     => $package_name,
    provider => $package_provider,
    source   => $package_source
  }

  if $manage_service == true {
    service { 'storm-statsd':
      ensure    => $service_ensure,
      enable    => $service_enable,
      hasstatus => true,
      provider  => $init_provider,
      subscribe => Class['storm_statsd::config'],
      require   => [
        Package['storm_statsd'],
        File['/var/log/storm-statsd']
      ],
    }
  }
}
