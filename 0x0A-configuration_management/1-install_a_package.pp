# This Puppet script installs `flask` from `pip3` with version 2.1.0

package { 'python3-pip':
  ensure   => installed,
}

exec { 'install-flask':
  command     => '/usr/bin/pip3 install flask==2.1.0 werkzeug==2.0.3',
  refreshonly => true,
  require     => Package['python3-pip'],
}