
class base-system {

  # basic dirs most classes need
  file { "/etc/portage":
    ensure => directory,
  }

  file { "/etc/portage/package.use":
    ensure  => directory,
    require => File['/etc/portage'],
  }

  file { "/etc/portage/package.keywords":
    ensure  => directory,
    require => File['/etc/portage'],
  }

  # platform defaults and some sensible use flags
  file { "/etc/make.conf":
    ensure  => file,
    content => template('base-system/make.conf'),
  }

  # basic timezone config for ready for Bern
  file { "/etc/localtime":
    ensure  => file,
    content => template('/usr/share/zoneinfo/Europe/Zurich'),
  }
  file { "/etc/timezone":
    ensure  => file,
    content => 'Europe/Zurich',
  }

}
