
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

  # i am using xmonad to tile windows for this player so its easier to control the gui
  package { "x11-wm/xmonad":
    ensure => installed,
  }

  package { "x11-wm/xmonad-contrib":
    ensure  => installed,
    require => Package['x11-wm/xmonad'],
  }

  file { "/var/lib/player/.config":
    ensure  => directory,
    owner   => 'player',
    group   => 'player',
  }

  file { "/var/lib/player/.config/autostart":
    ensure  => directory,
    owner   => 'player',
    group   => 'player',
    require => File['/var/lib/player/.config'],
  }

  file { "/var/lib/player/.config/autostart/00xmonad":
    ensure  => '/usr/bin/xmonad',
    require => [
      File['/var/lib/player/.config/autostart'],
      Package['x11-wm/xmonad'],
    ]
  }

  file { "/var/lib/player/.xmonad/":
    ensure  => directory,
  }

  file { "/var/lib/player/.xmonad/xmonad.hs":
    ensure  => file,
  }

  # emerge xprop and xterm for debugging (unneeded on prod)
  # also remove xfce4-panel to make it look nice
}
