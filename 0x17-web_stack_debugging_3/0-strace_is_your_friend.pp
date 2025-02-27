# Correct bad file extension `.phpp` to `php` in `wp-settings.php`

file { '/var/www/html/wp-settings.php':
  ensure => present;
}

-> exec { 'fix':
  command => "sed -i 's/.phpp/.php/' /var/www/html/wp-settings.php",
  path    => ['/bin', '/usr/bin'],
}
