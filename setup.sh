#! /bin/bash

## Constants ##########################################################################################################

TRUE=0
FALSE=1


## Shell ##############################################################################################################

function error() {
  log error "$1"
}

function info() {
  log info "$1"
}

function log() {
  if [[ "$1" == "error" ]]; then
    echo -e "! $2"
  else
    echo -e "> $2"
  fi
}

function is_module_installed() {
  module=$1
  module_list=$2

  local results=$(echo "$module_list" | grep $module);

  if [[ -z "$results" ]]; then
    return $FALSE
  else
    return $TRUE
  fi
}



## Shell ##############################################################################################################

info "Enabling Puppet package in Apt"

wget https://apt.puppetlabs.com/puppet7-release-jammy.deb /tmp --directory-prefix=/tmp
sudo dpkg -i /tmp/puppet7-release-jammy.deb

info "Updating packages list"

sudo apt-get update

info "Installing Puppet"

sudo apt-get install puppet-agent

if [[ $? -eq $TRUE ]]; then
  info "Puppet installed successfully"

  module_list=$(sudo /opt/puppetlabs/bin/puppet module list)

  for module in puppetlabs-apt puppetlabs-sshkeys_core puppetlabs-vcsrepo
  do
    is_module_installed $module "$module_list"

    if [[ $? -eq $FALSE ]]; then
      info "Installing Puppet module '$module'"

      sudo /opt/puppetlabs/bin/puppet module install $module

      if [[ $? -eq $TRUE ]]; then
        info "Puppet module '$module' installed successfully"
      else
        error "Unable to install Puppet module '$module'"
      fi
    else
      info "Puppet module '$module' already installed"
    fi
  done
else
  error "Unable to install Puppet"
  
  exit 1
fi

info "Importing Puppet configuration"

git clone https://github.com/Automattic/wp-calypso-bootstrap-wsl.git /tmp/calypso-bootstrap

info "Provisioning virtual machine"

sudo /opt/puppetlabs/bin/puppet apply /tmp/calypso-bootstrap/puppet/production/manifests/default.pp --modulepath=/etc/puppetlabs/code/environments/production/modules:/etc/puppetlabs/code/modules:/opt/puppetlabs/puppet/modules:/tmp/calypso-bootstrap/puppet/production/modules

info "Virtual machine provisioned successfully"