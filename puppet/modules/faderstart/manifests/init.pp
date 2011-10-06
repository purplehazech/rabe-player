
class faderstart {
  
  file { "/usr/local/share":
    ensure  => directory,
  }

  file { "/usr/local/share/faderstart":
    ensure  => directory,
    require => File['/usr/local/share'],
  }

  /**
   * contains a osc to midi gateway written in pd
   */
  file { "/usr/local/share/faderstart/faderstart-osc2midi-ard2.pd":
    ensure  => file,
    content => template('faderstart/faderstart-osc2midi-ard2.pd'),
    require => File['/usr/local/share/faderstart'],
  }

}
