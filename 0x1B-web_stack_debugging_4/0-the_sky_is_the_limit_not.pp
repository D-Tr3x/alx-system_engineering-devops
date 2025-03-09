# Puppet script to modify Nginx's configuration


exec { 'fix-for-nginx':
  command => 'sed -i "s/15/4096" /etc/default/nginx',
  path    => ['/usr/local/bin', '/bin'],
  unless  => 'grep -q "4096" /etc/default/nginx'
} ->

exec { 'nginx-restart':
  command => 'service nginx restart',
  path => ['/etc/init.d'],
  refreshonly => true
}

# exec { 'restart-nginx':
#  command     => '/bin/systemctl restart nginx',
#  path        => ['/bin', '/usr/bin', '/usr/sbin'],
#  refreshonly => true
# }
