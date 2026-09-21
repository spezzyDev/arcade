#!/bin/sh
export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppID=892970

SERVERNAME="Spezzy's Valheim"
WORLDNAME="spezpocket"
SECRET="tacopizza"

echo "Starting server PRESS CTRL-C to exit"
./valheim_server.x86_64 -name "${SERVERNAME}" -port 2456 -nographics -batchmode -world "${WORLDNAME}" -password "${SECRET}" -public 1
export LD_LIBRARY_PATH=$templdpath