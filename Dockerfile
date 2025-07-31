# Nutze ein Node.js Image als Basis
FROM node:18-alpine

# Arbeitsverzeichnis im Container setzen
WORKDIR /app

# package.json und package-lock.json kopieren und Abhängigkeiten installieren
COPY package*.json ./
RUN npm install

# Den Rest des App-Codes kopieren
COPY . .

# Port für den Vue-Entwicklungsserver freigeben
EXPOSE 8080

# Befehl zum Starten des Entwicklungsservers
CMD ["npm", "run", "serve"]