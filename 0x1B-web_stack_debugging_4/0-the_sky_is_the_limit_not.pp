# Puppet script to modify Nginx's configuration


file { '/etc/nginx/nginx.conf':
  ensure  => file,
  content => template('nginx/nginx.conf.erb'),
  notify  => Exec['restart-nginx']
}

exec { 'restart-nginx':
  command     => '/bin/systemctl restart nginx',
  path        => ['/bin', '/usr/bin', '/usr/sbin'],
  refreshonly => true
}
