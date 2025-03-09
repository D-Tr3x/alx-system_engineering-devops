# Change OS configuration to enable `holberton` user to login and open files without any errors

# Increase hard file limit
exec { 'increase-holberton-hard-limit':
  command => 'sed -i "/holberton hard/s/5/4096/" /etc/security/limits.conf',
  path    => ['/bin', '/usr/bin'],
  unless  => 'grep -q "holberton hard nofile 4096" /etc/security/limits.conf'
}

# Increase soft file limit
exec { 'increase-holberton-soft-limit':
  command => 'sed -i "/holberton soft/s/4/4096/" /etc/security/limits.conf',
  path    => ['/bin', '/usr/bin'],
  unless  => 'grep -q "holberton soft nofile 4096" /etc/security/limits.conf'
}
