Calypso Bootstrap (WSL)
=======================

[Calypso Bootstrap](https://github.com/Automattic/wp-calypso-bootstrap) is a **portable development environment** for [Calypso](https://github.com/Automattic/wp-calypso/), the powerful administration interface of [WordPress.com](http://wordpress.com). This specific version only works on Windows though, and allows you to run Calypso **faster** using the [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/) (WSL). This sandbox makes it very easy to learn about, test, and hack Calypso without messing with the configuration of your computer. It uses some cool technologies such as [Puppet](https://puppetlabs.com/puppet/what-is-puppet) under the hood.

### Prerequisites

You need to install [Git](https://git-scm.com/download/win) and [WSL](https://learn.microsoft.com/en-us/windows/wsl/install) first.

### Installing

The first step is to install a Ubuntu distribution:

1. Open a terminal, and run the following command (use `calypso` as username and password):
```
wsl --install Ubuntu-22.04
```
2. Exit the virtual machine, and check it is set as the _default_ one (there should be an asterisk in front of its name):
```
wsl -l -v

  NAME            STATE           VERSION
* Ubuntu-22.04    Running         2
```

The second step is to set up and provision that virtual machine. Note this process **can take some time** since it will update the guest system, install all the required packages, and finally download the Calypso repository:

3. Clone this repository to your computer:
```
git clone https://github.com/Automattic/wp-calypso-bootstrap-wsl.git Calypso
```
4. Navigate to that new folder, e.g.:
```
cd D:\WordPress\Calypso
```
5. Start and provision the virtual machine (update the path accordingly):
```
wsl /mnt/d/WordPress/Calypso/setup.sh
```
6. Finally, just add `127.0.0.1 calypso.localhost` to your `hosts` file.

### Running

First log into the virtual machine:
```
wsl
```

Then head to the Calypso directory:

```
calypso@computer:~$ cd /var/sources
```

And install dependencies with:

```
calypso@computer:/var/sources$ yarn
```

Start the application with:

```
calypso@computer:/var/sources$ yarn start
```

This will build Calypso, which can be a lengthy process. Hopefully at some point you'll see:

```
Ready! You can load http://calypso.localhost:3000/ now. Have fun!
```

You should now be able to access Calypso in your browser at http://calypso.localhost:3000!

### Hacking

The Calypso repository is located in `/var/sources` on the virtual machine. **This isn't a shared folder**, i.e. a directory that is shared between the virtual machine (the guest system) and your own computer (the host system). This was done for performance reason as well as to work around a number of limitations (most of them originating from running Windows as host system).

With Calypso Bootstrap you can either work from the virtual machine itself or from your computer. In the former case, you would edit files in the `/var/sources` folder directly. In the latter, you would have to sync this folder to your computer using a tool such as [rsync](https://en.wikipedia.org/wiki/Rsync) or [unison](http://www.cis.upenn.edu/~bcpierce/unison/) (which is installed by default). From there, you would be able to edit files using your favorite code editor.

### Troubleshooting

If you encounter any issues, check Calypso's [readme](https://github.com/Automattic/wp-calypso/blob/trunk/README.md) and [documentation](https://github.com/Automattic/wp-calypso/tree/trunk/docs). If you're still stuck, [we're here to help](https://github.com/Automattic/wp-calypso/blob/trunk/docs/CONTRIBUTING.md#were-here-to-help).

### License

Calypso Bootstrap is licensed under [GNU General Public License v2 (or later)](./LICENSE.md).
