
class vim {

  file { '/etc/portage/package.use/app-editors':
    ensure  => directory,
  }
  file { '/etc/portage/package.use/app-editors/vim':
    ensure  => file,
    content => 'app-editors/vim acl gpm nls perl python bash-completion ruby',
    require => File['/etc/portage/package.use/app-editors']
  }
  file { '/etc/bash_completion.d':
    ensure => directory
  }
  file { '/etc/bash_completion.d/vim':
    ensure  => '/usr/share/bash-completion/vim',
    require => File['/etc/bash_completion.d']
  }

  package { 'app-editors/vim':
    ensure  => installed,
    require => [
      File['/etc/portage/package.use/app-editors/vim'],
      File['/etc/bash_completion.d/vim']
    ]
  }

  # eselect config
  file { '/etc/env.d/99editor':
    ensure  => file,
    content => 'EDITOR="/usr/bin/vim"',
    require => Package['app-editors/vim']
  }

}
