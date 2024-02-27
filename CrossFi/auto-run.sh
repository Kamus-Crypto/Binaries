#!/bin/bash
clear

if [[ ! -f "$HOME/.bash_profile" ]]; then
    touch "$HOME/.bash_profile"
fi

if [ -f "$HOME/.bash_profile" ]; then
    source $HOME/.bash_profile
fi


echo "
░▒█░▄▀░█▀▀▄░▒█▀▄▀█░▒█░▒█░▒█▀▀▀█░░░▒█▀▀▄░▒█▀▀▄░▒█░░▒█░▒█▀▀█░▀▀█▀▀░▒█▀▀▀█
░▒█▀▄░▒█▄▄█░▒█▒█▒█░▒█░▒█░░▀▀▀▄▄░░░▒█░░░░▒█▄▄▀░▒▀▄▄▄▀░▒█▄▄█░░▒█░░░▒█░░▒█
░▒█░▒█▒█░▒█░▒█░░▒█░░▀▄▄▀░▒█▄▄▄█░░░▒█▄▄▀░▒█░▒█░░░▒█░░░▒█░░░░░▒█░░░▒█▄▄▄█
                       
                       Indonesia Crypto Community
          visit our website at https://kamuscrypto.super.site
      join our Discord community at https://discord.gg/c2mHnd8VHY
  
=====================CrossFi Node Auto Installation===================== " && sleep 1

read -p "Do you want to run CrossFi node? (y/n): " choice

if [ "$choice" == "y" ]; then


sudo apt update && sudo apt upgrade -y
sudo apt install curl git wget htop tmux build-essential jq make lz4 gcc unzip -y
wget https://github.com/crossfichain/crossfi-node/releases/download/v0.3.0-prebuild3/crossfi-node_0.3.0-prebuild3_linux_amd64.tar.gz && tar -xf crossfi-node_0.3.0-prebuild3_linux_amd64.tar.gz
cd $HOME
sudo chmod +x ./bin/crossfid
sudo mv ./bin/crossfid /usr/local/bin
crossfid version
cd $HOME
git clone https://github.com/crossfichain/testnet.git
sudo mv testnet .crossfid
cd $HOME
crossfid config chain-id crossfi-evm-testnet-1
crossfid config node tcp://localhost:26657
# Set Service file
sudo tee /etc/systemd/system/crossfid.service > /dev/null <<EOF
[Unit]
Description=crossfid
After=network-online.target
[Service]
User=$USER
ExecStart=$(which crossfid) start --home $HOME/.crossfid
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable crossfid
sudo systemctl restart crossfid
sudo journalctl -fu crossfid -o cat

fi
