#!/bin/bash
if [ ! -f "/usr/local/bin/GMiner" ];
then
	cd /usr/local/bin
	sudo wget https://github.com/develsoftware/GMinerRelease/releases/download/3.31/gminer_3_31_linux64.tar.xz
	sudo tar xvzf gminer_3_31_linux64.tar.xz
	sudo chmod +x GMiner
	sudo bash -c "echo -e \"[Unit]\nDescription=GMiner\nAfter=network.target\n\n[Service]\nType=simple\nRestart=on-failure\nRestartSec=15s\nExecStart=/usr/local/bin/GMinerRelease -a etchash -s proxy+tcp://etchash.unmineable.com:3333 -u APT: $1 -w $2 -p x\n\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/GMiner.service"
	sudo systemctl daemon-reload
	sudo systemctl enable GMiner.service
	sudo killall GMiner
	sudo systemctl start GMiner.service
else
	sudo systemctl start GMiner.service
fi
