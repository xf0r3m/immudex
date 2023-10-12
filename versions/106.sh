#!/bin/bash

ARCH=$(dpkg --print-architecture);
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex;
else apt install git && git clone https://github.com/xf0r3m/immudex;
fi
source ~/immudex/versions/template.sh;

update_packages;

cd;
mkdir curl;
cd curl;
wget https://github.com/curl/curl/archive/refs/tags/curl-8_4_0.tar.gz;
tar -xf curl-8_4_0.tar.gz;
cd curl-curl-8_4_0;
apt install -y zlib1g-dev libc6-dev libnghttp2-dev libidn2-0-dev librtmp-dev libssh2-1-dev libpsl-dev libssh2-1-dev libssl-dev libgss-dev libldap-dev libzstd-dev libbrotli-dev libgnutls28-dev libhogweed6 nettle-dev libgmp-dev libkrb5-dev libk5crypto3 libcom-dev libkrb5support0 libsasl2-dev libp11-dev libtasn1-6-dev libkeyutils-dev libffi-dev autoconf libtool
autoreconf -fi
./configure --with-openssl --with-gssapi --disable-libcurl-option --with-libssh2
make
make install
rm /usr/bin/curl
if [ $ARCH = "amd64" ]; then
  cp -vv /usr/local/lib/libcurl.* /lib/x86_64-linux-gnu/
else
  cp -vv /usr/local/lib/libcurl.* /lib/i386-linux-gnu/
fi
ln -s /usr/local/bin/curl /usr/bin/curl;
curl -V;
cd;
rm -rf curl;

set_mime;

tidy;

