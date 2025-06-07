FROM node:24

LABEL author="turzzhosting9870"
LABEL maintainer="Turzz Hosting VVIP"

# Update & install
RUN apt update && apt upgrade -y && \
    apt install -y python3 python3-pip curl wget nano git build-essential ffmpeg && \
    npm install -g pm2 && \
    rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /app
COPY . /app
RUN chmod +x start.sh

CMD ["bash", "start.sh"]
