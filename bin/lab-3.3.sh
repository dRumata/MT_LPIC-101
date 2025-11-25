#!/bin/bash
for i in {3..5}; do
    count=$((100 + i * 3))
    dd if=/dev/zero of="/var/$(date +%d%m%y%H%M%S).$count.backup" bs=1M count="$count"
done

for m in jan feb march apr; do
    man gpg > "/var/db-$m-2018.backup"
done
