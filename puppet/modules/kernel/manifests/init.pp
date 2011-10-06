
class kernel {
  
  file { "/etc/kernels":
    ensure  => directory,
  }

  file { "/etc/kernels/kernel-config-x86-2.6.39-gentoo-r3-rabeplayer-by-purplehaze":
    ensure  => file,
    content => template('kernel/kernel-config-x86-2.6.39-gentoo-r3-rabeplayer-by-purplehaze'),
  }

  file { "/etc/kernels/kernel-config-x86-2.6.39-gentoo-r3":
    ensure  => 'kernel-config-x86-2.6.39-gentoo-r3-rabeplayer-by-purplehaze',
    require => [
      File['/etc/kernels'],
      File['/etc/kernels/kernel-config-x86-2.6.39-gentoo-r3-rabeplayer-by-purplehaze'],
    ],
  }

  file { "/etc/genkernel.conf":
    ensure  => file,
    content => template('kernel/genkernel.conf'),
    require => Package['sys-kernel/genkernel'],
  }

  package { "sys-kernel/genkernel":
    ensure  => installed,
  }

  package { "sys-kernel/gentoo-sources":
    ensure  => installed,
    require => [
      File['/etc/kernels/kernel-config-x86-2.6.39-gentoo-r3'],
      Package['sys-kernel/genkernel'],
    ]
  }

}
