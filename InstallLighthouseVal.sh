#!/usr/bin/env bash
# cd /usr/local/bin
# sudo -u lighthouse lighthouse --network mainnet account validator import --directory $HOME/eth2deposit-cli/validator_keys --datadir /var/lib/lighthouse
cd /etc/systemd/system/
wget https://github.com/gordonbrice/node-pub/raw/main/lighthouseval.service
cd ~
systemctl daemon-reload
systemctl start lighthouseval
journalctl -fu lighthouseval.service
