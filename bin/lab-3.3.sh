#/bin/bash
dd if=/dev/zero of=/var/tmp/50.backup bs=1M count=5
dd if=/dev/zero of=/var/tmp/105.backup bs=1M count=105
dd if=/dev/zero of=/var/tmp/125.backup bs=1M count=125
dd if=/dev/zero of=/var/tmp/145.backup bs=1M count=145
dd if=/dev/zero of=/var/tmp/db-jan-2018.backup bs=1M count=5
cp /var/tmp/db-jan-2018.backup /var/tmp/db-feb-2018.backup
cp /var/tmp/db-jan-2018.backup /var/tmp/db-march-2018.backup
cp /var/tmp/db-jan-2018.backup /var/tmp/db-apr-2018.backup