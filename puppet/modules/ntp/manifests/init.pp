class ntp {
  
  package { 'net-misc/ntp':
    ensure => installed,
  }
  
  service { 'ntpd':
    name      => 'ntpd',
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ntp.conf'],
  }
  
  file { '/etc/ntp.conf':
    ensure  => file,
    source  => "/usr/share/puppet/modules/ntp/files/ntp.conf",
    require => Package['net-misc/ntp'],
  }
}
