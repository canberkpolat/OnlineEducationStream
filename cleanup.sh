#!/bin/bash
find /mnt/live/ -type f -name "*.ts" -cmin +180 -delete
find /mnt/live/ -type f -name "*.m3u8" -cmin +180 -delete
