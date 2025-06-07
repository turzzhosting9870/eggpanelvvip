#!/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

OS=$(uname -o)
DISTRO=$(lsb_release -d 2>/dev/null | cut -f2)
KERNEL=$(uname -r)
CPU_MODEL=$(grep -m 1 'model name' /proc/cpuinfo | cut -d ':' -f2 | xargs)
CPU_CORES=$(nproc)
RAM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
RAM_USED=$(free -m | awk '/Mem:/ {print $3}')
RAM_FREE=$(free -m | awk '/Mem:/ {print $4}')
DISK_TOTAL=$(df -h / | awk 'NR==2 {print $2}')
DISK_USED=$(df -h / | awk 'NR==2 {print $3}')
DISK_FREE=$(df -h / | awk 'NR==2 {print $4}')
IP_ADDRESS=$(hostname -I | awk '{print $1}')
UPTIME=$(uptime -p)
NODE_VER=$(node -v)
PYTHON_VER=$(python3 --version | awk '{print $2}')

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${CYAN}📦 TERIMA KASIH TELAH MENGGUNAKAN IMAGE PTERODACTYL CUSTOM"
echo -e "${YELLOW}--------------------------------------------------------------"
echo -e "${CYAN}📌 Tools Terinstal:"
echo -e "   • Node.js     : ${NODE_VER}"
echo -e "   • Python3     : ${PYTHON_VER} (auto support)"
echo -e "   • FFmpeg, Git, Curl, Chromium, dll"
echo -e ""
echo -e "${CYAN}🖥️ VPS Info:"
echo -e "   • OS          : ${DISTRO:-Unknown} ($OS)"
echo -e "   • Kernel      : ${KERNEL}"
echo -e "   • CPU         : ${CPU_MODEL} (${CPU_CORES} cores)"
echo -e "   • RAM         : ${RAM_TOTAL}MB total / ${RAM_USED}MB used / ${RAM_FREE}MB free"
echo -e "   • Disk        : ${DISK_TOTAL} total / ${DISK_USED} used / ${DISK_FREE} free"
echo -e "   • IP Address  : ${IP_ADDRESS}"
echo -e "   • Uptime      : ${UPTIME}"
echo -e "${YELLOW}--------------------------------------------------------------"
echo -e "${GREEN}🚀 Menjalankan bot kamu sekarang...\n${NC}"

# Jalankan index.js (Node.js bot)
exec node index.js
