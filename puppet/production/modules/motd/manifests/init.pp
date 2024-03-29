class motd {
  service { "ssh":
    ensure => running
  }

  file_line { "disable last login message":
    path   => "/etc/ssh/sshd_config",
    line   => "PrintLastLog no",
    match  => "^PrintLastLog (no|yes)$",
    notify => Service["ssh"]
  }

  file { "/etc/update-motd.d/00-header":
    ensure => present,
    source => "puppet:///modules/motd/00-header",
    mode   => "0755",
    owner  => "root",
    group  => "root",
    notify => Exec["generate motd"]
  }

  file { "/etc/update-motd.d/10-help-text":
    ensure => absent,
    notify => Exec["generate motd"]
  }

  file { "/etc/update-motd.d/50-motd-news":
    ensure => absent,
    notify => Exec["generate motd"]
  }

  exec { "generate motd":
    command => "/bin/run-parts /etc/update-motd.d > /var/run/motd.dynamic"
  }
}
