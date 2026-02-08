echo "Preparing Game..."

mkdir -p /home/gamer/.config/love/
cp -r /balatro/mods/ /home/gamer/.config/love/Mods

chown -R gamer:gamer /home/gamer/.config/love

echo "Running Game..."
su gamer -c '
Xvfb :1 -ac -nolisten tcp -nolisten unix &

timeout -k 30s 5s sh -c "DISPLAY=:1 LD_PRELOAD=/balatro/liblovely.so LOVELY_MOD_DIR=/home/gamer/.config/love/Mods love /balatro/game"
'
pkill -9 -U gamer # Make sure no processes are left running
