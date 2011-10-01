
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
    content => '=media-sound/mixxx-1.9.0 ~x86',
  }
  file { '/etc/portage/package.keywords/media-libs/portmidi':
    ensure => file,
    content => '=media-libs/portmidi-217 ~x86',
  }

  # mixxx needs qt3support which depends on some qt3 useflags
  # i'm not actuall 100% sure that this is needed for mixxx-1.9.0
  # but its still in here since i started building on an old mixxx
  # version. i'll try to get rid of this in the next iteration.
  file { '/etc/portage/package.use/x11-libs':
    ensure => directory,
  }
  file { '/etc/portage/package.use/x11-libs/qt-gui':
    ensure => file,
    content => 'x11-libs/qt-gui qt3support',
  }
  file { '/etc/portage/package.use/x11-libs/qt-core':
    ensure => file,
    content => 'x11-libs/qt-core qt3support',
  }
  file { '/etc/portage/package.use/x11-libs/qt-sql':
    ensure => file,
    content => 'x11-libs/qt-sql qt3support',
  }
  file { '/etc/portage/package.use/x11-libs/qt-phonon':
    ensure => file,
    content => 'x11-libs/qt-phonon qt2support',
  }
  package { 'x11-libs/qt-qt3support':
    ensure => installed,
  }

  # install package
  package { 'media-sound/mixxx':
    ensure => installed,
  }
}