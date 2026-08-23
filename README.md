# NixOS dotfiles

## Before installing

Beware of Nvidia shader cache environment variables, specifically the
size and path. You might want to take a look at [nvidia.nix](./modules/system/nvidia.nix)

## Installation

To setup NixOS with this configuration, first temporally install git:
```sh
nix-shell -p git
```

Clone this repo at your *user home directory*:
```sh
git clone git@github.com:ivangzn/dotfiles.git ~/.dotfiles
```

Then copy your `hardware-configuration.nix` file 
by running the installation script:
```sh
./install.sh
```

## Maintaining

After using [install.sh](./install.sh) for the first time, 
you can use the bash alias `rebuild` to update your system.

## Manual

Some applications needs manual configuration for the moment:

### LACT

1. Run it and then import [the dotfile](dotfiles/lact/).

### Rclone

There are some systemd daemons that will trigger syncs with Google
Drive but fail, if you don't setup a drive called **gdrive**.

1. Run `rclone config`.
2. Setup a drive of type `drive`, which is Google Drive.
3. Go to [Google Cloud](https://console.cloud.google.com/).
4. Select your rclone project.
5. Go to APIs.
6. Go to Credentials, and copy client ID, and generate a new client password.
7. Remove any remaining old client password.