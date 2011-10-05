class jack {

  file { "/etc/portage/package.use/media-sound":
    ensure  => directory,
  }

  file { "/etc/portage/package.use/media-sound/jack-audio-connection-kit":
    ensure  => file,
    content => 'media-sound/jack-audio-connection-kit jack-tmpfs jackmidi alsa mmx sse',
    require => File['/etc/portage/package.use/media-sound'],
  }

  file { "/etc/portage/package.use/media-sound/qjackctl":
    ensure  => file,
    content => 'media-sound/qjackctl alsa jackmidi',
    require => File['/etc/portage/package.use/media-sound'],
  }

  file { "/etc/portage/package.keywords/sys-apps/":
    ensure => directory,
  }

  file { "/etc/portage/package.keywords/sys-apps/jackd-init":
    ensure  => file,
    content => '>=sys-apps/jackd-init-0.5 ~x86',
    require => File['/etc/portage/package.keywords/sys-apps/'],
  }

  package { "media-sound/jack-audio-connection-kit":
    ensure  => installed,
    require => File['/etc/portage/package.use/media-sound/jack-audio-connection-kit'],
  }

  # init scrits for system startup jack
  package { "sys-apps/jackd-init":
    ensure  => installed,
    require => [
    	Package['media-sound/jack-audio-connection-kit'],
	File['/etc/portage/package.keywords/sys-apps/jackd-init'],
	File['/etc/portage/package.use/media-sound/qjackctl'],
    ]
  }

  package { "media-sound/alsa-utils":
    ensure => installed,
  }

  file { "/etc/conf.d/jackd":
    ensure  => file,
    content => template('jack/jackd'),
  }

  service { "alsasound":
    enable  => true,
    ensure  => running,
    require => Package['media-sound/alsa-utils'],
  }

  service { "jackd":
    ensure  => running,
    require => [
      Package['sys-apps/jackd-init'],
      File['/etc/conf.d/jackd'],
      Service['alsasound'],
    ],
  }
}
