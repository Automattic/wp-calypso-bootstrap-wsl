class yarn {
  package { "yarn":
    ensure => latest
  }

  file { "/home/calypso/.npmrc":
    ensure => present,
    source => "puppet:///modules/yarn/.npmrc",
    mode   => "0644",
    owner  => "calypso",
    group  => "calypso"
  }
}
