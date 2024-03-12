class github::known_hosts {
  # Makes sure the system file that contains SSH keys of known hosts is readable by all users. This basically fixes the
  # Puppet bug mentioned in http://bit.ly/1BNtqDv.
  file { "/etc/ssh/ssh_known_hosts":
    ensure => file,
    mode   => "0644"
  }
}
