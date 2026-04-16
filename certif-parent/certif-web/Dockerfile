# certif-web/Dockerfile
# CertifApp Frontend Angular 18 PWA — Build multi-stage
# Stage 1 (dev)     : node:20-alpine — ng serve (hot reload)
# Stage 2 (builder) : node:20-alpine — ng build --configuration=production
# Stage 3 (runtime) : nginx:alpine   — serve dist/

# =============================================================================
# STAGE DEV — ng serve avec hot reload
# =============================================================================
FROM node:20-alpine AS dev

WORKDIR /app

# Copie package.json en premier pour le cache npm
COPY package.json package-lock.json ./
RUN npm ci --prefer-offline

COPY . .

EXPOSE 4200

# ng serve sur 0.0.0.0 pour être accessible depuis le host
CMD ["npx", "ng", "serve", "--host", "0.0.0.0", "--port", "4200", "--poll", "2000"]

# =============================================================================
# STAGE BUILDER — Build de production
# =============================================================================
FROM node:20-alpine AS builder

ARG API_URL=https://api.certifapp.com/api/v1
ARG BUILD_ENV=production

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --prefer-offline --omit=dev

COPY . .

# Build optimisé : SSG désactivé (SPA), PWA activée, output hashing
RUN npx ng build \
    --configuration=${BUILD_ENV} \
    --output-hashing=all \
    --source-map=false

# =============================================================================
# STAGE RUNTIME — nginx serveur statique
# =============================================================================
FROM nginx:1.27-alpine AS runtime

LABEL maintainer="CertifApp Team"
LABEL description="CertifApp Frontend Angular 18 PWA"

# Suppression de la config nginx par défaut
RUN rm /etc/nginx/conf.d/default.conf

# Config nginx optimisée pour SPA Angular
COPY nginx.conf /etc/nginx/conf.d/certifapp.conf

# Copie des fichiers buildés depuis le stage builder
COPY --from=builder /app/dist/certif-web/browser /usr/share/nginx/html

# Permissions lecture seule
RUN chmod -R 755 /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD wget -q --spider http://localhost:80/health || exit 1

CMD ["nginx", "-g", "daemon off;"]
