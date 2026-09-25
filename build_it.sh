#!/bin/bash
set -e
cd "$(dirname "$0")"

HEX=PIC-Messaging.hex
PK2=/home/tscarlson/pk2cmd/pk2cmd/pk2cmd
PART=PIC12F1840
DO_EE=1

if [ "$1" = "--noeeprom" ] || [ "$1" = "-noeeprom" ]; then
  DO_EE=0
fi

rm -f *.o *.hex *.cod *.lst *.map *.err

for f in *.ASM; do
  echo "==== $f ===="
  gpasm -c -I. "$f"
done

gplink -s ./12f1840_messaging.lkr -m -o "$HEX" *.o
ls -l "$HEX"
echo "OK build"

if [ ! -s "$HEX" ] || [ ! -x "$PK2" ]; then
  echo "hex or pk2cmd missing"
  exit 1
fi

echo "Hold MCLR, then Enter"
read

set +e
export PATH="$PATH:/usr/share/pk2"

if [ "$DO_EE" -eq 1 ]; then
  echo "==== ERASE + FLASH + CONFIG ===="
  "$PK2" -P$PART -W -F"$PWD/$HEX" -M
  echo "==== EEPROM ===="
  "$PK2" -P$PART -W -F"$PWD/$HEX" -ME
else
  echo "==== FLASH + CONFIG, EE preserved ===="
  "$PK2" -P$PART -W -F"$PWD/$HEX" -Z -M
fi

echo "==== EE dump 0-2F ===="
"$PK2" -P$PART -W -GE 0-2F

echo "==== VERIFY ALL ===="
"$PK2" -P$PART -W -F"$PWD/$HEX" -Y

echo "==== release reset ===="
"$PK2" -P$PART -W -I -R

echo "back in $PWD  DO_EE=$DO_EE"
