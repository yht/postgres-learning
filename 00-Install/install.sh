#!/bin/sh
# Install PostgreSQL di Debian trixie (testing/unstable)

# cek root
if [ "$EUID" -ne 0 ]; then
	echo "Maaf, Anda tidak berhak melakukan pemasangan" 1>&2
	exit 1
fi

# non-interaktif agar cocok untuk otomatisasi
export DEBIAN_FRONTEND=noninteractive

# cek apt-get
if [ -x /usr/bin/apt-get ]; then
	apt-get update
	apt-get install -y postgresql postgresql-client
else
	echo "Maaf, skrip ini hanya untuk OS linux dengan pemaketan Debian" 1>&2
	exit 1
fi

# enable & start service (systemd)
systemctl enable postgresql
systemctl start postgresql
