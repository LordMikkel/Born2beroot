<div align="center">
  
# 🚀 Born2beRoot: Building a Secure Debian Server from Scratch
  
![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![VirtualBox](https://img.shields.io/badge/VirtualBox-183A61?style=for-the-badge&logo=virtualbox&logoColor=white)
</div>

<hr>

<div align="center">
  This comprehensive guide covers the configuration of a Debian server with strict security protocols, virtualization, and automation. It breaks down the core concepts, technical implementations, and essential system administration skills.
</div>

<hr>

## 📋 Table of Contents
- [Key Concepts](#-key-concepts-explored)
- [Technologies & Tools](#-technologies--tools)
- [System Architecture](#%EF%B8%8F-system-architecture--folder-structure)
- [Challenges & Learnings](#-challenges-and-learnings)

<hr>


## 🌟 Key Concepts Explored

<hr>

### 🖥️ Virtual Machines (VMs)
A VM simulates a computer within your physical machine, allowing you to run isolated operating systems. Using **VirtualBox** to create a Debian VM teaches how hypervisors allocate resources (CPU, RAM, storage) between the host (physical machine) and guest (VM). Key advantages:
- Run multiple OS environments simultaneously
- Safely test configurations without affecting the host
- Efficiently share hardware resources

### 🔪 LVM (Logical Volume Manager)
LVM abstracts storage management, enabling flexible disk allocation beyond traditional partitioning:

- **Physical Volumes (PVs)**: Raw storage devices (disks or partitions)
- **Volume Groups (VGs)**: Pools of PVs that create a unified storage resource
- **Logical Volumes (LVs)**: Virtual partitions that can be resized dynamically

By encrypting LVs, you ensure data protection even if physical access to the disk is compromised.

### 🛠️ Sudo (Superuser Do)
Sudo is a powerful command-line utility that allows permitted users to execute commands as the superuser:

- **Fine-grained permissions** via custom rules in /etc/sudoers.d/
- **Password authentication** required for all sudo commands
- **Session logging** to /var/log/auth.log for audit trails

### 📦 APT vs Aptitude
Both APT (Advanced Package Tool) and Aptitude are package management tools for Debian-based systems:

- **APT:** Pure CLI tool • Uses apt-get/apt commands for basic operations
- **Aptitude:** Hybrid CLI/TUI • Interactive interface with keyboard navigation
- **APT:** Minimal dependency resolution • Fails on complex conflicts
- **Aptitude:** Smart solver • Auto-suggests dependency fixes

### 🖥️ Why No GUI?
Designed for efficiency and hardening:

- **Resource conservation:** Saves CPU/RAM for critical services
- **CLI mastery:** Forces hands-on Linux sysadmin skill development
- **Headless optimization:** Aligns with server/VM best practices
- **SSH compatibility:** Streamlines remote management workflows

### Security & Hardening

#### 🛡️ AppArmor
A Mandatory Access Control (MAC) system that restricts program capabilities by confining applications to a limited set of resources. AppArmor profiles define what files a program can access and what operations it can perform, providing protection against vulnerabilities and exploits.

#### 🔐 SSH (Secure Shell)
A cryptographic network protocol for secure remote administration:
- Configured on non-standard port `4242` to reduce automated scanning attacks
- Disabled root login to prevent brute force attempts on the most privileged account
- Implemented key-based authentication for stronger security than passwords
- Limited connection attempts to prevent brute force attacks

#### 🧱 UFW (Uncomplicated Firewall)
A user-friendly interface for managing iptables firewall rules:
- Allows only essential ports (e.g., SSH on `4242`)
- Blocks unnecessary traffic to reduce attack surface
- Logs connection attempts for security monitoring
- Provides simple command syntax for firewall management

#### 🔒 Password Policies
Implemented robust authentication requirements:
- Expiration: Forces regular password updates (every 30 days)
- Complexity: Requires uppercase letters, numbers, and special characters
- History: Prevents reuse of previous passwords
- Login attempt limits: Protects against brute force attacks

#### 👥 User & Group Management
Created a structured access control system:
- Custom users assigned to specific groups like `sudo` and `user42`
- Restricted sudo privileges with custom rules in `/etc/sudoers.d/`
- Implemented logging for all sudo commands
- Applied principle of least privilege across the system

### Automation & Monitoring

#### 📜 Bash Scripting
Created `monitoring.sh` to track real-time metrics including:
- CPU usage and specifications
- RAM allocation and availability
- Disk space consumption
- Network statistics and active connections
- Last boot time and system uptime

#### ⏲️ Cron
The system's task scheduler that enables:
- Automated execution of monitoring script every 10 minutes
- Regular system maintenance without manual intervention
- Scheduled backups and updates
- Custom timing specifications for recurring tasks

### ⭐ Bonus: WordPress & Web Services

#### Web Stack Components
- **Lighttpd**: A lightweight, high-performance web server optimized for speed, efficiency, and minimal resource usage
- **MariaDB**: A community-developed fork of MySQL offering improved performance and additional features
- **PHP**: Server-side scripting language powering dynamic content generation
- **WordPress**: Content management system built on PHP and MySQL/MariaDB
- **LiteSpeed**: High-performance HTTP server and load balancer with integrated caching

<hr>

## 🔧 Technologies & Tools

<hr>

### Core System Commands

#### System Information
| Command | Description |
|:--------|:------------|
| `lscpu` | Displays detailed CPU architecture information including cores, threads, and cache |
| `uname -a` | Shows kernel version, hostname, and system architecture |
| `hostnamectl` | Manages system hostname and related settings |
| `lsblk` | Lists block devices (hard drives, partitions, etc.) in a tree-format |
| `df -h` | Reports filesystem disk space usage in human-readable format |
| `vmstat` | Reports virtual memory statistics including processes, memory, paging, and CPU activity |

#### Text Processing
| Command | Description |
|:--------|:------------|
| `wc` | Counts lines, words, and characters in files |
| `awk` | Processes columns: Extracts and manipulates data based on columns or fields |
| `grep` | Filters rows: Searches for patterns in text and displays matching lines |

#### Service Management
| Command | Description |
|:--------|:------------|
| `systemctl` | Controls the systemd system and service manager |
| `journalctl` | Queries and displays logs from journald |
| `hostnamectl` | Manages the system hostname and related settings (e.g., static/transient) |

#### Network Analysis
| Command | Description |
|:--------|:------------|
| `ip link` | Shows network interfaces and their state |
| `ss` | inspecting network sockets for Monitoring network connections in real-time |
| `netstat` | Network statistics tool for connections and routing tables |

📊 Monitoring Script

The monitoring.sh script provides a comprehensive overview of the system's status

```
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
```
It collects and displays the following information:

Architecture: Operating system and kernel version
Physical CPU: Number of physical cores
Virtual CPU: Number of virtual processors
Memory Usage: Used/total memory and percentage
Disk Usage: Used/total disk space and percentage
CPU Load: Current utilization percentage
Last Boot: Date and time of the last system start
LVM Use: Indicates if the system is using LVM
TCP Connections: Number of established TCP connections
Logged Users: Number of currently connected users
Network: IP and MAC address of the network interface
Sudo: Number of commands executed with sudo

<hr>

## 🗂️ System Architecture & Folder Structure

<hr>

### Key System Directories
```
/boot - Mounted from separate unencrypted partition (sda1)

/ (root) -  Mounted from LVMGroup-root on encrypted volume (sda5_crypt)
├── /etc            # System-wide configuration files
│   ├── /ssh        # SSH server and client configurations
│   ├── /ufw        # Firewall rules and settings
│   ├── /cron.d     # System cron jobs
│   ├── /passwd     # User account information
│   └── /sudoers.d  # Custom sudo permissions
├── /var            # Variable data files
│   ├── /log        # System logs - Mounted from LVMGroup-var-log
│   ├── /www/html   # Web server document root
│   └── /lib/mysql  # Database files
├── /bin & /sbin    # Essential binaries and system admin tools
├── /srv            # Service data - Mounted from LVMGroup-srv
├── /tmp            # Temporary files - Mounted from LVMGroup-tmp
└── /home           # User home directories - Mounted from LVMGroup-home

```

### Logical Volume Structure
- **System Volume**: Contains root filesystem
- **Home Volume**: Separate storage for user data
- **Var Volume**: Isolated space for logs and web content
- **Swap Volume**: Virtual memory extension

<hr>

## 🖥️ Getting Started: Using the Virtual Machine

<hr>

This pre-configured Debian virtual machine is available for download at:
https://mega.nz/file/dNtRAD6R#-9eB0DRIbEJJw2SD9x_k1T6DJ5G1ro7VzAxfSxkGedM

### 🔑 Login Credentials
- **Username**: migarrid
- **Password**: Mikel42bcn-
- **Disk Encryption Password**: Mikel42bcn-
- **Sudo Password**: Mikel42bcn-

> ⚠️ **Note:** Using identical passwords for all authentication levels is done for demonstration purposes only. In a production environment, unique strong passwords should be used for each security level.

### ⚙️ Initial Setup

1. **Download and Import the VM**:
   - Download the VM file (.ova) from the provided link
   - Open VirtualBox and select "Import Appliance" from the File menu
   - Select the downloaded file and follow the prompts to complete the import

2. **Boot the VM**:
   - Start the VM from VirtualBox
   - When prompted, enter the disk encryption password: `Mikel42bcn-`
   - Log in with username `migarrid` and password `Mikel42bcn-`

3. **Basic Commands**:
   - Check system status: `systemctl status`
   - View active services: `systemctl list-units --type=service --state=active`
   - Check firewall status: `sudo ufw status`
   - View SSH configuration: `sudo cat /etc/ssh/sshd_config`

### 🌐 Remote Access

To connect to the VM remotely via SSH:

1. Ensure the VM is running
2. From your host machine, use:
   ```
   ssh migarrid@localhost -p 4242
   ```
3. Enter the password when prompted: `Mikel42bcn-`


<hr>

## 📚 Challenges and Learnings

<hr>

This project has provided a comprehensive foundation in enterprise-level server administration. Key skills developed include:

- **Security Implementation**: Creating defense-in-depth strategies with multiple security layers, implementing least-privilege access control, and enforcing strong authentication.

- **System Administration**: Managing packages, configuring services, monitoring system health, and performing routine maintenance tasks.

- **Network Management**: Setting up secure remote access, configuring firewalls, and implementing proper network isolation.

- **Automation**: Developing scripts for system monitoring and maintenance, scheduling recurring tasks, and creating efficient workflows.

- **Service Deployment**: Configuring web servers, databases, and application environments securely and efficiently.

This hands-on experience has demonstrated the interconnected nature of various system components and the importance of holistic security approaches in Linux environments.

<hr>

## 🏆 Credits

Developed by **Mikel Garrido** as part of the 42 curriculum.
🔗 [GitHub: LordMikkel](https://github.com/LordMikkel)

