class ntp {
  
  package { "net-misc/ntp":
    ensure => installed,
  }
  
  service { "ntpd":
    enable  => true,
    ensure  => running,
    require => Package['net-misc/ntp'],
  }
  
  file { "/etc/ntp.conf":
    ensure  => file,
    content => template('ntp/ntp.conf'),
    notify  => Service['ntpd'],
    require => Package['net-misc/ntp'],
  }

}
