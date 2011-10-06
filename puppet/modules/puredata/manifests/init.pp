class puredata {

  file { '/etc/portage/package.keywords/virtual':
    ensure  => directory
  }

  file { '/etc/portage/package.keywords/virtual/pd':
    ensure  => file,
    content => '>=puredata-base/pd-extended-0.42.5',
    require => File['/etc/portage/package.keywords/virtual']
  }

  package { 'puredata-base/pd-extended':
    ensure  => installed,
    require => [
      File['/etc/portage/package.keywords/virtual/pd'],
    ]
  }

}
