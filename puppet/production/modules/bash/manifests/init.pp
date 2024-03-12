class bash {
  file { "/root/.bash_aliases":
    ensure => present,
    source => "puppet:///modules/bash/.bash_aliases",
    mode   => "0644",
    owner  => "root",
    group  => "root"
  }

  file { "/home/calypso/.bash_aliases":
    ensure => present,
    source => "puppet:///modules/bash/.bash_aliases",
    mode   => "0644",
    owner  => "calypso",
    group  => "calypso"
  }

  file { "/home/calypso/.screenrc":
    ensure => present,
    source => "puppet:///modules/bash/.screenrc",
    mode   => "0644",
    owner  => "calypso",
    group  => "calypso"
  }
}
