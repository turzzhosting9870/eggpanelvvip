FROM node:24-bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install dependency dasar dan Python multi versi support
RUN apt update && apt install -y \
    software-properties-common \
    curl wget git nano unzip zip \
    build-essential \
    ffmpeg \
    chromium \
    neofetch htop net-tools iproute2 iputils-ping \
    ca-certificates \
    python3 python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Alias python → python3 dan pip → pip3
RUN ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip

# Folder kerja bot
WORKDIR /app

# Salin semua file
COPY . .

# Izin eksekusi
RUN chmod +x /start.sh

# Jalankan
CMD ["/start.sh"]
