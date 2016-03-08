case $operatingsystem {
  /^(Debian|Ubuntu)$/: { include apt }
  'RedHat', 'CentOS':  { include epel }
  default: { notify { 'unsupported os!': }}
}

class { 'nodejs': manage_package_repo => true, repo_url_suffix => '5.x', }->
class { 'storm_statsd':
  servers => [
    {
      host     => 'http://localhost/',
      username => 'user',
      password => 'pass',
      prefix   => 'bar.storm.yay',
      tags     => {
        foo => 'bar'
      }
    }
  ],
  statsd  => {
    host     => 'localhost',
    port     => 8125,
    interval => 10,
    prefix   => 'foo'
  }
}
