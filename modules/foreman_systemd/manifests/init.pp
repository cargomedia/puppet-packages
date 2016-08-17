class foreman_systemd {
  
  require 'foreman'
  
  file {'/usr/local/bin/foreman-systemd':
    owner => 'root',
    group => 'root',
    mode  => '0755',
    content => template('foreman_systemd/binary.sh'),
  }
}
