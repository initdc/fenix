FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8' TERM=screen

WORKDIR /home/khadas/fenix

RUN set -e \
    && dpkg --add-architecture i386

RUN set -e \
    && sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list \
    && apt update
    
RUN set -e \
    && apt-get install --no-install-recommends -y \
    # sorting by https://build.moz.one
    acl aptly bash-completion bc  \
    binfmt-support binutils bison  \
    bsdmainutils btrfs-progs build-essential  \
    ca-certificates ccache cpio curl  \
    debian-archive-keyring debian-keyring  \
    debootstrap device-tree-compiler dialog  \
    dosfstools e2fsprogs e2tools f2fs-tools  \
    fakeroot fdisk file flex  \
    g++-10-arm-linux-gnueabihf gawk  \
    gcc-8-arm-linux-gnueabihf  \
    gcc-arm-linux-gnueabihf gettext git kmod  \
    lib32ncurses6 lib32stdc++6 lib32tinfo6  \
    lib32z1 libbison-dev  \
    libc6-dev-armhf-cross libc6-i386  \
    libfile-fcntllock-perl libfl-dev  \
    libglib2.0-dev liblz4-tool  \
    libncurses5-dev libpython2.7-dev  \
    libssl-dev libtool libusb-1.0-0-dev  \
    linux-base locales lsb-release lzop  \
    mtools ncurses-base ncurses-term ntpdate  \
    parted patchutils pigz pixz pkg-config  \
    pv python2 python3 qemu-user-static  \
    rsync sudo swig systemd-container tzdata  \
    u-boot-tools udev unzip uuid-dev  \
    uuid-runtime wget whiptail xxd zip  \
    zlib1g-dev zlib1g:i386 zstd  \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8

# Switch to normal user
RUN useradd -c 'khadas' -m -d /home/khadas -s /bin/bash khadas
RUN set -e \
    && sed -i -e '/\%sudo/ c \%sudo ALL=(ALL) NOPASSWD: ALL' /etc/sudoers \
    && usermod -a -G sudo khadas

USER khadas

ENTRYPOINT [ "/bin/bash" ]
