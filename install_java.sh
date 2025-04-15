#!/bin/bash

# Usage: ./install_java.sh [java_version]
# Example: ./install_java.sh 17   (or just ./install_java.sh, which installs 11)

set -e

JAVA_VERSION=${1:-11}  # Default to 11 if no version is passed

detect_os() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
  else
    echo "❌ Unsupported OS."
    exit 1
  fi
}

install_java_debian() {
  echo "📦 Installing Java $JAVA_VERSION on Debian/Ubuntu..."

  sudo apt-get update -y
  sudo apt-get install -y openjdk-"$JAVA_VERSION"-jdk

  JAVA_HOME_PATH=$(update-java-alternatives -l | grep "java-${JAVA_VERSION}" | awk '{print $3}')
  if [[ -z "$JAVA_HOME_PATH" ]]; then
    JAVA_HOME_PATH="/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64"
  fi
}

install_java_rhel() {
  echo "📦 Installing Java $JAVA_VERSION on RHEL/CentOS..."

  sudo yum install -y java-"$JAVA_VERSION"-openjdk java-"$JAVA_VERSION"-openjdk-devel

  JAVA_HOME_PATH=$(dirname $(dirname $(readlink -f $(which javac))))
}

set_java_env() {
  echo "🔧 Setting JAVA_HOME to $JAVA_HOME_PATH"

  echo "export JAVA_HOME=$JAVA_HOME_PATH" | sudo tee /etc/profile.d/java.sh > /dev/null
  echo 'export PATH=$JAVA_HOME/bin:$PATH' | sudo tee -a /etc/profile.d/java.sh > /dev/null
  sudo chmod +x /etc/profile.d/java.sh
  source /etc/profile.d/java.sh

  echo "🔁 Updating alternatives..."
  sudo update-alternatives --install /usr/bin/java java "$JAVA_HOME_PATH/bin/java" 1
  sudo update-alternatives --install /usr/bin/javac javac "$JAVA_HOME_PATH/bin/javac" 1
  sudo update-alternatives --set java "$JAVA_HOME_PATH/bin/java"
  sudo update-alternatives --set javac "$JAVA_HOME_PATH/bin/javac"
}

already_installed() {
  CURRENT_VERSION=$(java -version 2>&1 | head -n 1 || true)
  echo "🔍 Current Java: $CURRENT_VERSION"

  if [[ "$CURRENT_VERSION" == *"$JAVA_VERSION"* ]]; then
    echo "✅ Java $JAVA_VERSION is already installed."
    exit 0
  fi
}

main() {
  echo "📥 Requested Java version: $JAVA_VERSION"
  detect_os
  already_installed

  case "$OS" in
    ubuntu|debian)
      install_java_debian
      ;;
    centos|rhel|rocky|almalinux|fedora)
      install_java_rhel
      ;;
    *)
      echo "❌ Unsupported OS: $OS"
      exit 1
      ;;
  esac

  set_java_env
  echo "✅ Java $JAVA_VERSION installation complete!"
  java -version
}

main

