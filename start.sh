#!/bin/bash

clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "     🔰 Selamat Datang di Panel Turzz Hosting 🔰"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""

# Info VPS
echo -e "\033[1;33m📊 Informasi Sistem:\033[0m"
echo -e "🖥️  Hostname: \033[1;32m$(hostname)\033[0m"
echo -e "🌐 IP Lokal : \033[1;32m$(hostname -I | awk '{print $1}')\033[0m"
echo -e "🕒 Uptime   : \033[1;32m$(uptime -p)\033[0m"
echo -e "💿 OS       : \033[1;32m$(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '\"')\033[0m"
echo -e "⚙️ Kernel   : \033[1;32m$(uname -r)\033[0m"
echo -e "🧠 RAM Total: \033[1;32m$(free -h | awk '/^Mem:/ {print $2}')\033[0m"
echo -e "📦 Disk     : \033[1;32m$(df -h / | awk 'NR==2 {print $2 " total, " $4 " free"}')\033[0m"
echo ""

# Info Tools
echo -e "\033[1;34m📘 Versi Bahasa & Tools:\033[0m"
echo -e "🔹 Node.js  : \033[1;36m$(node -v 2>/dev/null || echo 'Tidak terpasang')\033[0m"
echo -e "🔹 NPM      : \033[1;36m$(npm -v 2>/dev/null || echo 'Tidak terpasang')\033[0m"
echo -e "🔹 Python   : \033[1;36m$(python3 --version 2>/dev/null || echo 'Tidak terpasang')\033[0m"
echo -e "🔹 PIP      : \033[1;36m$(pip3 --version 2>/dev/null | awk '{print $2}' || echo 'Tidak terpasang')\033[0m"
echo -e "🔹 PM2      : \033[1;36m$(pm2 -v 2>/dev/null || echo 'Tidak terpasang')\033[0m"
echo ""

echo -e "\033[1;32m✔️ Semua tool terinstall dengan baik dan siap digunakan\033[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""

# --- Start Project ---
if [[ -f package.json ]]; then
    if [[ ! -d node_modules ]]; then
        echo -e "\033[1;34m📦 Menjalankan 'npm install' karena node_modules belum ada...\033[0m"
        npm install
    else
        echo -e "\033[1;32m📦 Dependensi sudah terinstall\033[0m"
    fi

    if grep -q '"start"' package.json; then
        echo -e "\033[1;35m🚀 Menjalankan 'npm start' melalui PM2...\033[0m"
        pm2 start npm --name turzzbot -- start
        pm2 logs
    else
        echo -e "\033[1;31m❌ Tidak ditemukan perintah 'start' di package.json\033[0m"
        bash
    fi

# --- Python (.py auto detect) ---
elif ls *.py &>/dev/null; then
    mainpy=$(ls *.py | head -n 1)
    echo -e "\033[1;35m🐍 Menjalankan file Python: $mainpy melalui PM2...\033[0m"
    pm2 start "python3 $mainpy" --name turzzpy
    pm2 logs

else
    echo -e "\033[1;31m❌ Tidak ditemukan file yang bisa dijalankan (tidak ada package.json atau .py)\033[0m"
    bash
fi
