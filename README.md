<div align="center">
  
# 🚀 Born2beRoot: Building a Secure Debian Server from Scratch
  
![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![VirtualBox](https://img.shields.io/badge/VirtualBox-183A61?style=for-the-badge&logo=virtualbox&logoColor=white)
</div>

<hr>

<div align="center">
  This comprehensive guide covers the configuration of a headless Debian server with strict security protocols, virtualization, and automation. It breaks down the core concepts, technical implementations, and essential system administration skills.
</div>


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

- **Granular permissions** via custom rules in /etc/sudoers.d/
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
| `ip link` | Shows network interfaces and their state |

#### Text Processing
| Command | Description |
|:--------|:------------|
| `wc` | Counts lines, words, and characters in files |
| `awk` | Powerful text processing tool for data extraction and reporting |
| `grep` | Searches for patterns in text and filters output |

#### Service Management
| Command | Description |
|:--------|:------------|
| `systemctl` | Controls the systemd system and service manager |
| `journalctl` | Queries and displays logs from journald |

#### Network Analysis
| Command | Description |
|:--------|:------------|
| `ss` | Shows socket statistics (replaced netstat) |
| `netstat` | Network statistics tool for connections and routing tables |

<hr>

## 🗂️ System Architecture & Folder Structure

<hr>

### Key System Directories
```
/ (root)
├── /boot           # Kernel images and bootloader configuration
├── /etc            # System-wide configuration files
│   ├── /ssh        # SSH server and client configurations
│   ├── /ufw        # Firewall rules and settings
│   ├── /cron.d     # System cron jobs
│   ├── /passwd     # User account information
│   └── /sudoers.d  # Custom sudo permissions
├── /var            # Variable data files
│   ├── /log        # System logs including sudo operations
│   ├── /www/html   # Web server document root
│   └── /lib/mysql  # MariaDB database files
├── /bin & /sbin    # Essential binaries and system admin tools
└── /home           # User home directories with personal files
```

### Logical Volume Structure
- **System Volume**: Contains root filesystem
- **Home Volume**: Separate storage for user data
- **Var Volume**: Isolated space for logs and web content
- **Swap Volume**: Virtual memory extension

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

