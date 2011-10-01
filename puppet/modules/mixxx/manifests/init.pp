
class mixxx {

  # package USE flags
  file { '/etc/portage/package.use/media-sound':
    ensure => directory,
  }
  file { '/etc/portage/package.use/media-sound/mixxx':
    ensure => file,
    content => 'media-sound/mixxx -vinylcontrol',
  }

  # package mask
  file { '/etc/portage/package.keywords/media-sound':
    ensure => directory,
  }
  file { '/etc/portage/package.keywords/media-sound/mixxx':
    ensure => file,
    content => '=media-sound/mixxx-1.6.1 ~x86',
  }

  # mixxx needs qt3support which depends on some qt3 useflags
  file { '/etc/portage/package.use/x11-libs':
    ensure => directory,
  }
  file { '/etc/portage/package.use/x11-libs/qt-gui':
    ensure => file,
    content => 'x11-libs/qt-gui qt3support'
  }
  file { '/etc/portage/package.use/x11-libs/qt-core':
    ensure => file,
    content => 'x11-libs/qt-core qt3support'
  }
  file { '/etc/portage/package.use/x11-libs/qt-sql':
    ensure => file,
    content => 'x11-libs/qt-sql qt3support'
  }
  package { 'x11-libs/qt-qt3support':
    ensure => installed,
  }

  # install package
  package { 'media-sound/mixxx':
    ensure => installed,
  }
}
