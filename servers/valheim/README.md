# README
These steps are appliacable for OpenSUSE Tumbleweed!

## Server Setup
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
sudo chmod +x installUpdate.sh
sudo chmod +x run.sh
```

Creating Valheim Service: 
```
sudo vi /etc/systemd/system/valheim.service
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

## Backup Setup: 
The scripts, and service specs are found in the repo dir.

Write the script, valheim-backup.sh: 
```
sudo vi /usr/local/bin/valheim-backup.sh
```

Write the service, valheim-backup.service: 
```
sudo vi /etc/systemd/system/valheim-backup.service
```

Write the timer, valheim-backup.timer: 
```
sudo vi /etc/systemd/system/valheim-backup.timer
```

Enable the backup services: 
```
sudo systemctl daemon-reload
sudo systemctl enable --now valheim-backup.timer
sudo systemctl list-timers valheim-backup.timer
```

> Note: Valheim autosaves periodically too, so there's a small chance a backup catches the .db/.fwl mid-write during a simultaneous autosave which is an acceptable risk for a 15-min rolling backup