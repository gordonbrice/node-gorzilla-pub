#!/usr/bin/env bash
host=$1
apt update
apt upgrade -y
apt dist-upgrade
apt autoremove
ufw allow 13000/tcp comment 'prysm'
ufw allow 12000/udp comment 'prysm'
ufw enable
ufw status numbered
useradd --no-create-home --shell /bin/false prysm
sudo -u prysm mkdir /var/lib/prysm
cd /usr/bin
sudo -u prysm wget https://raw.githubusercontent.com/prysmaticlabs/prysm/master/prysm.sh
sudo -u prysm chmod u+x /usr/bin/prysm.sh
cd /etc/systemd/system
sudo -u prysm wget https://github.com/gordonbrice/node-pub/raw/main/prysm-bn.service
cd /var/lib/prysm
sudo -u prysm wget https://github.com/gordonbrice/node-pub/raw/main/prysm-bn.yaml
sed -i.bak '' /usr/lib/prysm/prysm-bn.yaml
sed -i 's/p2p-host-ip: "xxx.xxx.xxx.xxx"/p2p-host-ip: '$host'/' /usr/lib/prysm/prysm-bn.yaml
systemctl daemon-reload
systemtl start prysm-bn
journalctrl -fu prysm-bn
