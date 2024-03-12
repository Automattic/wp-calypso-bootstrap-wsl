class github {
  require github::known_hosts

  package { "git":
    ensure => latest
  }

  vcsrepo { "/var/sources":
    ensure   => present,
    provider => git,
    revision => "trunk",
    source   => "https://github.com/Automattic/wp-calypso.git",
    owner    => "calypso",
    group    => "calypso",
    require  => Package["git"]
  }
}
