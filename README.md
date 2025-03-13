<div align="center">

# 🚀 Born2beRoot
## Building a Secure Debian Server from Scratch

![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![VirtualBox](https://img.shields.io/badge/VirtualBox-183A61?style=for-the-badge&logo=virtualbox&logoColor=white)

</div>

<hr>

<div align="center">
  This comprehensive guide covers the configuration of a headless Debian server with strict security protocols, virtualization, and automation. It breaks down the core concepts, technical implementations, and essential system administration skills.
</div>

<hr>

## 📋 Table of Contents
- [Key Concepts](#-key-concepts-explored)
- [Technologies & Tools](#-technologies--tools)
- [System Architecture](#-system-architecture--folder-structure)
- [Challenges & Learnings](#-challenges-and-learnings)
- [Skills Acquired](#-skills-acquired)

<hr>

## 🌟 Key Concepts Explored

### <img src="/api/placeholder/25/25" align="center" alt="VM"> Virtual Machines (VMs)
A VM simulates a computer within your physical machine, allowing you to run isolated operating systems. Using **VirtualBox** to create a Debian VM teaches how hypervisors allocate resources (CPU, RAM, storage) between the host (physical machine) and guest (VM). 

| Advantages |
|:-----------|
| ✅ Run multiple OS environments simultaneously |
| ✅ Safely test configurations without affecting the host |
| ✅ Efficiently share hardware resources |

### <img src="/api/placeholder/25/25" align="center" alt="LVM"> LVM (Logical Volume Manager)
LVM abstracts storage management, enabling flexible disk allocation beyond traditional partitioning:

| Component | Description |
|:----------|:------------|
| **Physical Volumes (PVs)** | Raw storage devices (disks or partitions) |
| **Volume Groups (VGs)** | Pools of PVs that create a unified storage resource |
| **Logical Volumes (LVs)** | Virtual partitions that can be resized dynamically |

**Key Benefits:**
- 📊 Resize volumes without downtime
- 💾 Add storage capacity on-the-fly
- 📸 Create snapshots for backup purposes
- 🔄 Migrate data between physical disks without disruption

By encrypting LVs, you ensure data protection even if physical access to the disk is compromised.

### <img src="/api/placeholder/25/25" align="center" alt="Security"> Security & Hardening

#### 🛡️ AppArmor
A Mandatory Access Control (MAC) system that restricts program capabilities by confining applications to a limited set of resources. AppArmor profiles define what files a program can access and what operations it can perform, providing protection against vulnerabilities and exploits.

#### 🔐 SSH (Secure Shell)
A cryptographic network protocol for secure remote administration:
- 🔢 Configured on non-standard port `4242` to reduce automated scanning attacks
- 🚫 Disabled root login to prevent brute force attempts on the most privileged account
- 🔑 Implemented key-based authentication for stronger security than passwords
- 🔒 Limited connection attempts to prevent brute force attacks

#### 🧱 UFW (Uncomplicated Firewall)
A user-friendly interface for managing iptables firewall rules:
- ✅ Allows only essential ports (e.g., SSH on `4242`)
- ❌ Blocks unnecessary traffic to reduce attack surface
- 📝 Logs connection attempts for security monitoring
- 🛠️ Provides simple command syntax for firewall management

#### 🔐 Password Policies
Implemented robust authentication requirements:
- ⏱️ **Expiration**: Forces regular password updates (every 30 days)
- 🔡 **Complexity**: Requires uppercase letters, numbers, and special characters
- 🗂️ **History**: Prevents reuse of previous passwords
- 🔄 **Login attempt limits**: Protects against brute force attacks

#### 👥 User & Group Management
Created a structured access control system:
- 👤 Custom users assigned to specific groups like `sudo` and `user42`
- 🔒 Restricted sudo privileges with custom rules in `/etc/sudoers.d/`
- 📊 Implemented logging for all sudo commands
- 🎯 Applied principle of least privilege across the system

### <img src="/api/placeholder/25/25" align="center" alt="Automation"> Automation & Monitoring

#### 📜 Bash Scripting
Created `monitoring.sh` to track real-time metrics including:
- 💻 CPU usage and specifications
- 🧠 RAM allocation and availability
- 💾 Disk space consumption
- 🌐 Network statistics and active connections
- ⏱️ Last boot time and system uptime

#### ⏰ Cron
The system's task scheduler that enables:
- 🔄 Automated execution of monitoring script every 10 minutes
- 🛠️ Regular system maintenance without manual intervention
- 💾 Scheduled backups and updates
- ⏲️ Custom timing specifications for recurring tasks

### <img src="/api/placeholder/25/25" align="center" alt="WordPress"> Bonus: WordPress & Web Services

#### Web Stack Components
- **Lighttpd**: A lightweight, high-performance web server optimized for speed, efficiency, and minimal resource usage
- **MariaDB**: A community-developed fork of MySQL offering improved performance and additional features
- **PHP**: Server-side scripting language powering dynamic content generation
- **WordPress**: Content management system built on PHP and MySQL/MariaDB
- **LiteSpeed**: High-performance HTTP server and load balancer with integrated caching

<hr>

## 🔧 Technologies & Tools

### Core System Commands

<details>
<summary><b>System Information Commands</b></summary>
<br>

| Command | Description |
|:--------|:------------|
| `lscpu` | Displays detailed CPU architecture information including cores, threads, and cache |
| `uname -a` | Shows kernel version, hostname, and system architecture |
| `hostnamectl` | Manages system hostname and related settings |
| `lsblk` | Lists block devices (hard drives, partitions, etc.) in a tree-format |
| `df -h` | Reports filesystem disk space usage in human-readable format |
| `vmstat` | Reports virtual memory statistics including processes, memory, paging, and CPU activity |
| `ip link` | Shows network interfaces and their state |

</details>

<details>
<summary><b>Text Processing Commands</b></summary>
<br>

| Command | Description |
|:--------|:------------|
| `wc` | Counts lines, words, and characters in files |
| `awk` | Powerful text processing tool for data extraction and reporting |
| `grep` | Searches for patterns in text and filters output |

</details>

<details>
<summary><b>Service Management Commands</b></summary>
<br>

| Command | Description |
|:--------|:------------|
| `systemctl` | Controls the systemd system and service manager |
| `journalctl` | Queries and displays logs from journald |

</details>

<details>
<summary><b>Network Analysis Commands</b></summary>
<br>

| Command | Description |
|:--------|:------------|
| `ss` | Shows socket statistics (replaced netstat) |
| `netstat` | Network statistics tool for connections and routing tables |

</details>

### Security Frameworks

<details>
<summary><b>UFW (Uncomplicated Firewall)</b></summary>
<br>
UFW provides a simplified interface to the complex iptables firewall system. It uses a rule-based model where you can:

- Allow or deny traffic based on port numbers
- Restrict connections by IP address or subnet
- Create named application profiles
- Log firewall events for security analysis
</details>

<details>
<summary><b>SSH (Secure Shell)</b></summary>
<br>
SSH creates encrypted tunnels for secure remote administration. Key security features include:

- Custom port configuration to reduce automated scanning
- Disabling direct root login
- Key-based authentication
- Connection attempt limiting
</details>

<details>
<summary><b>MariaDB</b></summary>
<br>
A relational database management system that powers WordPress and other dynamic applications, with robust security configurations.
</details>

<details>
<summary><b>Cron</b></summary>
<br>
A time-based job scheduler in Unix-like systems for automating recurring tasks.
</details>

<hr>

## 🗂️ System Architecture & Folder Structure

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

| Volume | Purpose |
|:-------|:--------|
| **System Volume** | Contains root filesystem |
| **Home Volume** | Separate storage for user data |
| **Var Volume** | Isolated space for logs and web content |
| **Swap Volume** | Virtual memory extension |

<hr>

## 🛑 Challenges and Learnings

Throughout this project, I encountered and overcame several technical challenges including:

- 🔐 **LVM encryption implementation**
- 🛡️ **SSH hardening**
- 🧱 **Firewall configuration**
- 📊 **Creating persistent monitoring solutions**
- 🗄️ **Securing database access**

Each challenge presented unique learning opportunities and led to deeper understanding of Linux system administration.

<hr>

## 📚 Skills Acquired

<div align="center">
  
  ### This project has provided a comprehensive foundation in enterprise-level server administration.
  
</div>

| Skill Area | Competencies Gained |
|:-----------|:--------------------|
| **Security Implementation** | <ul><li>Creating defense-in-depth strategies</li><li>Implementing least-privilege access control</li><li>Enforcing strong authentication</li></ul> |
| **System Administration** | <ul><li>Managing packages</li><li>Configuring services</li><li>Monitoring system health</li><li>Performing routine maintenance</li></ul> |
| **Network Management** | <ul><li>Setting up secure remote access</li><li>Configuring firewalls</li><li>Implementing proper network isolation</li></ul> |
| **Automation** | <ul><li>Developing monitoring scripts</li><li>Scheduling recurring tasks</li><li>Creating efficient workflows</li></ul> |
| **Service Deployment** | <ul><li>Configuring web servers</li><li>Setting up databases</li><li>Deploying applications securely</li></ul> |

<div align="center">
  
  ### This hands-on experience has demonstrated the interconnected nature of various system components and the importance of holistic security approaches in Linux environments.
  
</div>

<hr>

<div align="center">
  Made with ❤️ using Markdown
</div>

