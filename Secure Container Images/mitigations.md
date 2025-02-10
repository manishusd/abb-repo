Mitigation Steps for Container Vulnerabilities

1. Update Base Image  
Current base image: `node:10`  
Mitigation: Update to `node:18-alpine` or higher to receive the latest security patches.

2. Secure Dependencies  
Vulnerable Package: `express@2.5.11`
Mitigation: Upgrade to `express@4.18.2` or higher.(Built in in node base images)

3. Avoid using `--legacy-peer-deps` unless necessary.


# Generated for below Dockerfile (Vulnerable)

FROM node:10 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm i --legacy-peer-deps
COPY . .

FROM node:10
WORKDIR /app
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/src ./src

RUN npm i express@2.5.11 
EXPOSE 3000
CMD ["node", "src/server.js"]

# Corrected Dockerfile:

FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm i
COPY . .

FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/src ./src
RUN npm i --only=production
EXPOSE 3000
CMD ["node", "src/server.js"]

