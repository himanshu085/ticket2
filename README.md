
# 🧰 Java Installation Script

---

### 📄 Metadata

| Field             | Value                             |
|------------------|-----------------------------------|
| **Author**        | Himanshu                          |
| **Created on**    | 2025-04-15                        |
| **Version**       | 1.0                               |
| **Last updated by** | Himanshu                       |
| **Last edited on** | 2025-04-14                      |
| **Internal Reviewer** | Komal Jaiswal                |
| **Reviewer L0**   | Imran                             |
| **Reviewer L1**   | Shashi                            |
| **Reviewer L2**   | Mahesh Kumar                      |

---

### 📘 Overview

`install_java.sh` is a **cross-platform Bash script** designed to simplify Java (OpenJDK) installation on both **Debian/Ubuntu** and **RHEL/CentOS/Fedora** Linux systems.

It supports:

- 📥 Installing any Java version (`8`, `11`, `17`, etc.)
- 🔁 Automatic upgrade if the version is already outdated
- 🧠 OS detection and dynamic handling via `apt` or `yum/dnf`
- ✅ Automatically sets up `JAVA_HOME` and updates the environment path

---

### 🚀 Usage

#### ✅ Run the Script

```bash
chmod +x install_java.sh
./install_java.sh [java_version]
```

#### 📌 Examples

Install **Java 11** (default):

```bash
./install_java.sh
```

Install **Java 17**:

```bash
./install_java.sh 17
```

---

### 🖥 Supported Operating Systems

| OS Family    | Supported Versions              |
|-------------|----------------------------------|
| Debian/Ubuntu | Ubuntu 18.04+, Debian 10+       |
| RHEL/CentOS  | CentOS 7+, RHEL 7+, Fedora, Rocky, AlmaLinux |

---

### 🔍 Features

- OS detection via `/etc/os-release`
- Version check and conditional upgrade
- Auto JAVA_HOME export in `/etc/profile.d/java.sh`
- Uses `update-alternatives` to manage multiple Java versions

---

### 🛠 Dependencies

- `bash`
- `sudo`
- `apt` (Debian-based systems)
- `yum` or `dnf` (RHEL-based systems)

---

### 🧪 Output Sample

```bash
📥 Requested Java version: 17
📦 Installing Java 17 on RHEL/CentOS...
🔧 Setting JAVA_HOME to /usr/lib/jvm/java-17-openjdk-...
🔁 Updating alternatives...
✅ Java 17 installation complete!
openjdk version "17.0.9" 2024-01-16
```

---

### 🧹 Uninstallation (Manual)

#### Debian/Ubuntu:
```bash
sudo apt remove openjdk-11-jdk
```

#### RHEL/CentOS:
```bash
sudo yum remove java-11-openjdk
```

---

### 📞 Contact Information

| Name               | Email Address                                      |
|--------------------|----------------------------------------------------|
| Himanshu Parashar  | himanshu.parashar.snaatak@mygurukulam.co          |

---

### 📚 References

- [OpenJDK Installation Docs (Ubuntu)](https://help.ubuntu.com/community/Java)
- [Red Hat Java OpenJDK Guide](https://access.redhat.com/documentation/en-us/openjdk/)
- OS detection using `/etc/os-release`
- Community best practices for setting JAVA_HOME in `/etc/profile.d`

---
