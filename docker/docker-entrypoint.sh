#!/bin/sh

set -ex

patch_conf() {
    echo $PASS | sudo -S ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
    export DEBIAN_FRONTEND=noninteractive
    DEBIAN_FRONTEND=noninteractive echo $PASS | sudo -S apt install -y libssl-dev \
    meson rustc libgtk-4-dev libadwaita-1-dev libgstreamer-plugins-bad1.0-dev libdbus-1-dev \
    gettext cmake  desktop-file-utils cargo &&
    echo $PASS | sudo -S dpkg-reconfigure --frontend noninteractive tzdata &&
    echo $PASS | sudo -S locale-gen en_US.UTF-8 &&
    touch $NETEASE_MUSIC_INITIALIZED_MARK &&
    echo "export PATH=$PATH:/usr/local/bin" >>~/.bashrc
}

if [ ! -f "$NETEASE_MUSIC_INITIALIZED_MARK" ]; then
    patch_conf
    echo
    echo 'building env init process complete; ready for start up.'
    echo
else
    echo
    echo 'Skipping initialization'
    echo
    echo 'done'
    echo
    
fi

/bin/sh -c "$@"
