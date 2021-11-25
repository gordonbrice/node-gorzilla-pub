#!/usr/bin/env bash
apt update
apt upgrade -y
apt dist-upgrade
apt autoremove
ufw allow 9000  comment 'lighthouse / teku'
wget https://github.com/sigp/lighthouse/releases/download/v2.0.1/lighthouse-v2.0.1-x86_64-unknown-linux-gnu.tar.gz
tar xvf lighthouse-v2.0.1-x86_64-unknown-linux-gnu.tar.gz
cp lighthouse /usr/local/bin
cd /usr/local/bin/
./lighthouse --version
cd ~
rm lighthouse
rm lighthouse-v1.4.0-x86_64-unknown-linux-gnu.tar.gz
useradd --no-create-home --shell /bin/false lighthouse
chown -R lighthouse:lighthouse /usr/local/bin/lighthouse
mkdir -p /var/lib/lighthouse
chown -R lighthouse:lighthouse /var/lib/lighthouse
sudo -u lighthouse mkdir /var/lib/lighthouse/validator_keys
# cd /usr/local/bin
# sudo -u lighthouse lighthouse --network mainnet account validator import --directory $HOME/eth2deposit-cli/validator_keys --datadir /var/lib/lighthouse
sudo -u lighthouse mkdir -p /var/lib/lighthouse/beacon
chmod 700 /var/lib/lighthouse/beacon
cd /etc/systemd/system
curl -LO https://github.com/gordonbrice/node-pub/raw/main/lighthousebn.service
cd ~
systemctl daemon-reload
systemctl start lighthousebn
systemctl enable lighthousebn
journalctl -fu lighthousebn.service
