# Configures Nginx using `puppet` such that:
# - The name of the custom HTTP header is `X-Served-By`
# - The value of the custom HTTP header is the hostname

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
  content => 'Hello World!',
  require => Package['nginx'],
}

file { '/var/www/html/404.html':
  ensure  => file,
  content => 'Not Found!',
  require => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => @(END)
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    add_header X-Served-By "${::hostname}";

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;
    }

    error_page 404 /404.html;
    location /404 {
        internal;
    }
}
| END
  ,
  require => Package['nginx'],
  notify  => Service['nginx'],

}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
