# Configures Nginx using `puppet` such that:
# the name of the custom HTTP header is `X-Served-By`
# the value of the custom HTTP header is the hostname

exec { 'dist update':
  command  => '/usr/bin/apt-get update',
  provider => 'shell',
}

package { 'nginx':
  ensure  => installed,
  require => Exec['dist update'],
}

file { '/var/www/html/index.html':
  ensure  => file,
  mode    => '0644',
  content => 'Hello World!',
  require => Package['nginx'],
}

exec { 'redirect_me':
  command => 'sed -i "24i\\ 	rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-available/default',
  provider => 'shell',
  require  => Package['nginx'],
}

exec { 'custom_http_header':
  command  => "sed -i \"25i\\    add_header X-Served-By \\\"\\\$(hostname)\\\";\" /etc/nginx/sites-available/default",
  provider => 'shell',
  require  => Package['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
