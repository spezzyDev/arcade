# README
These steps are appliacable for OpenSUSE Tumbleweed!

## Setup
Installing SteamCMD:
```
sudo zypper addrepo https://download.opensuse.org/repositories/games:tools/openSUSE_Tumbleweed/games:tools.repo
sudo zypper refresh
sudo useradd -m steam
sudo passwd steam
sudo zypper install steamcmd-0.20180105-13.18.x86_64
```

Additional Requirements: 
```
sudo zypper libatomic1 libc6-32bit libgcc_s1 glibc-32bit
```

Creating Valheim Root Dir: 
```
mkdir /etc/gamesrv/valheim/
```

Installing installUpdate and run.sh scripts: 
```
cd /etc/gamesrv/valheim
sudo vi installUpdate.sh
sudo vi run.sh
```

Creating Valheim Service: 
```
sudo vi /etc/systemd/system/valheim.service
``` 

Service Spec: 
```
[Unit]
Description=Valheim Dedicated Server
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=steam
WorkingDirectory=/etc/gamesrv/valheim/
ExecStart=/etc/gamesrv/valheim/run.sh
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Enabling Valheim Service: 
```
sudo systemctl daemon-reload
sudo systemctl enable --now valheim.service
```

Open Firewall Ports: 
```
sudo firewall-cmd --add-port=2456-2457/udp --permanent
```