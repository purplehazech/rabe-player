
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

}
