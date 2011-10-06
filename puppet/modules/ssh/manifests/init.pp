
class ssh {

  package { "virtual/ssh":
    ensure  => installed,
  }

  service { "sshd":
    enable  => true,
    ensure  => running,
    require => Package['virtual/ssh'],
  }

  file { "/etc/ssh/sshd_config": 
    ensure  => file,
    content => template('ssh/sshd_config'),
    notify  => Service['sshd'],
  }

  file { "/var/lib/player/.ssh":
    ensure  => directory,
  }

  # allowing me for test purposes
  file { "/var/lib/player/.ssh/authorized_keys":
    ensure  => file,
    content => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAvv0JHfOaqUR0XShL66xUw5lWQQSwoo8IdRigObgcPrWKc8BrYDjQmWGuyLG/Y14v0XLZ/xv6qyX6yRVLWJNm2PsO7g739KZWvIC49kMhfqjEm7hr2NHaQVNuAJlavE7JLt9WjRPY5GvTYAjnBB49rTATT+wPshNMlnI/cnf21Cn+0kbltB6q8lIeo/gDW8XYsTCPKvikSPAAFgUozljnwW7DNeFlag8e8pPAB1VFJOafwJPZ++jyUPFd0+gCOCk7pvfOlVST/r6Iplyw4K5KkcWhxWMCz5MvYkC9jUSmGjpfaQvbExordbeNr+zkvTGsj8XWVLWV0KK0LwBvVBDFOQ== hairmare@dora.valinor',
    require => File['/var/lib/player/.ssh'],
  }

}
