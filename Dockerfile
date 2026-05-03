FROM node:20-slim

# 1. System-Abhängigkeiten (inkl. wget/curl für das interne Update)
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    make \
    g++ \
    libavahi-compat-libdnssd-dev \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/meta

# 2. Den Code direkt klonen (statt das unsichere bash-Skript zu nutzen)
# Wir klonen den Release-Branch
RUN git clone -b Release https://github.com/jac459/meta.git .

# 3. Abhängigkeiten installieren
RUN npm install --omit=dev

# 4. Verzeichnisse vorbereiten
RUN mkdir -p active library

# Ports öffnen
EXPOSE 3000 3100 4016

# Startbefehl
# Falls die Hauptdatei index.js heißt, bitte anpassen
CMD ["node", "meta.js"]
