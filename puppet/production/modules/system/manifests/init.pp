class system {
  include apt

  apt::source { "nodejs":
    key => {
      id => "9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280",
      server => "hkp://keyserver.ubuntu.com:80"
    },
    location => "https://deb.nodesource.com/node_20.x"
  }

  apt::source { "yarn":
    key => {
      id => "72ECF46A56B4AD39C907BBB71646B01B86E50310",
      source => "https://dl.yarnpkg.com/debian/pubkey.gpg"
    },
    location => "https://dl.yarnpkg.com/debian/",
    release  => "stable",
    repos    => "main"
  }

  exec { "update system":
    command => "/usr/bin/apt-get update",
    require => [Apt::Source["nodejs"], Apt::Source["yarn"]]
  }

  exec { "upgrade system":
    command => "/usr/bin/apt-get upgrade --assume-yes",
    path    => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"],
    require => Exec["update system"],
    timeout => 0
  }

  package { "openssh-server":
    ensure  => installed,
    require => Exec["upgrade system"],
  }

  file_line { "increase file watcher system limit":
    ensure => present,
    line   => "fs.inotify.max_user_watches=30000",
    path   => "/etc/sysctl.conf"
  }

  exec { "make new file watcher system limit effective":
    command => "/sbin/sysctl -p",
    require => File_line["increase file watcher system limit"]
  }

  file { "/etc/profile.d/playwright-skip-download.sh":
    ensure => present,
    source => "puppet:///modules/system/playwright-skip-download.sh",
    mode   => "0644",
    owner  => "root",
    group  => "root",
  }
}
