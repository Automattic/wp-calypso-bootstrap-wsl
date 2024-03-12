class nodejs {
  package { "nodejs":
    ensure => latest
  }

  exec { "install n":
    command => "/usr/bin/npm install -g n",
    require => Package["nodejs"]
  }

  exec { "switch node version":
    command => "/usr/bin/n i 20.8.1",
    require => Exec["install n"]
  }

  file { "/etc/profile.d/node-options.sh":
    ensure => present,
    source => "puppet:///modules/nodejs/node-options.sh",
    mode   => "0644",
    owner  => "root",
    group  => "root",
  }
}
