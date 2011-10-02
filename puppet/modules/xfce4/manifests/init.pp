
class xfce4 {
  
  file { '/etc/portage/package.use/x11-libs':
    ensure  => directory,
  }
  file { '/etc/portage/package.use/x11-libs/cairo':
    ensure  => file,
    content => 'x11-libs/cairo X',
    require => File['/etc/portage/package.use/x11-libs'],
  }

  file { '/etc/portage/package.use/xfce-base':
    ensure  => directory,
  }
  file { '/etc/portage/package.use/xfce-base/xfce4-meta':
    ensure  => file,
    content => 'xfce-base/xfce4-meta minimal',
    require => File['/etc/portage/package.use/xfce-base']
  }

  package { 'xfce-base/xfce4-meta':
    ensure  => installed,
    require => [
      File['/etc/portage/package.use/x11-libs/cairo']
    ]
  }

}
