#!/bin/env bash

sudo mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
sudo mdadm --create --verbose /dev/md0 -l 10 -n 4 /dev/sd{b,c,d,e}
sudo mkfs.ext4 /dev/md0
sudo mkdir /mnt/raid10
sudo mount /dev/md0 /mnt/raid10


