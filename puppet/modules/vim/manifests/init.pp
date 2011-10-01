
class vim {

  file { '/etc/portage/package.use/app-editors':
    ensure  => directory,
  }
  file { '/etc/portage/package.use/app-editors/vim':
    ensure  => file,
    content => 'app-editors/vim acl gpm nls perl python bash-completion ruby',
    require => File['/etc/portage/package.use/app-editors']
  }

  package { 'app-editors/vim':
    ensure  => installed,
    require => [
      File['/etc/portage/package.use/app-editors/vim']
    ]
  }

  # eselect config
  file { '/etc/env.d/99editor':
    ensure  => file,
    content => 'EDITOR="/usr/bin/vim"',
    require => Package['app-editors/vim']
  }

}
