#!/bin/bash
set -e
cd "$(dirname "$0")"

HEX=PIC-Messaging.hex
PK2DIR="$HOME/pk2cmd/pk2cmd"

rm -f *.o *.hex *.cod *.lst *.map *.err

for f in *.ASM; do
  echo "==== $f ===="
  gpasm -c -I. "$f"
done

gplink -s ./12f1840_messaging.lkr -m -o "$HEX" *.o
ls -l "$HEX"
echo "OK build"

if [ ! -s "$HEX" ]; then
  echo "no hex, not programming"
  exit 1
fi

cp "$HEX" "$PK2DIR/$HEX"

set +e
(
  cd "$PK2DIR"
  export PATH="$PATH:/usr/share/pk2"
  ./pk2cmd -PPIC12F1840 -W -I
  ./pk2cmd -PPIC12F1840 -W -F"$HEX" -M
  ./pk2cmd -PPIC12F1840 -W -F"$HEX" -Y
)
echo "back in $PWD"