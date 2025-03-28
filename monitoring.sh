#!/bin/bash

# ARCH
arch=$(uname -srmo)

# CPU PHYSICAL
cpuf=$(lscpu | awk '/Socket\(s\)/ {sockets=$2} /Core\(s\) per socket/ {cores=$4} END {print sockets * cores}')

# CPU VIRTUAL
cpuv=$(lscpu | awk '/^CPU\(s\):/ {print $2}')

# RAM
ram_total=$(free --mega | awk '$1 == "Mem:" {print $2}')
ram_use=$(free --mega | awk '$1 == "Mem:" {print $3}')
ram_percent=$(free --mega | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

# DISK
disk_total=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_t += $2} END {printf ("%.1fGb\n"), disk_t/1024}')
disk_use=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} END {print disk_u}')
disk_percent=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} {disk_t+= $2} END {printf("%d"), disk_u/disk_t*100}')

# CPU LOAD
cpul=$(vmstat 1 2 | tail -1 | awk '{printf $15}')
cpu_op=$(expr 100 - $cpul)
cpu_fin=$(printf "%.1f" $cpu_op)

# LAST BOOT
lb=$(who -b | awk '$1 == "system" {print $3 " " $4}')

# LVM USE
lvmu=$(lsblk | grep -q lvm && echo "yes" || echo "no")

# TCP CONNEXIONS
tcpc=$(ss -tan | grep -c 'ESTAB')

# USER LOG
ulog=$(users | wc -w)

# NETWORK
ip=$(hostname -I)
mac=$(ip link | grep "link/ether" | awk '{print $2}')

# SUDO
cmnd=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "  #Architecture: $arch
  #CPU physical: $cpuf
  #vCPU: $cpuv
  #Memory Usage: $ram_use/${ram_total}MB ($ram_percent%)
  #Disk Usage: $disk_use/${disk_total} ($disk_percent%)
  #CPU load: $cpu_fin%
  #Last boot: $lb
  #LVM use: $lvmu
  #Connections TCP: $tcpc ESTABLISHED
  #User log: $ulog
  #Network: IP $ip ($mac)
  #Sudo: $cmnd cmd"

