# certif-parent/certif-web/Dockerfile
# Multi-stage build — Angular 18 PWA → Nginx
# Stage 1 : npm build production
# Stage 2 : Nginx alpine (image ~25 MB)

# ── Stage 1 : Builder ─────────────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Copier package.json en premier pour profiter du cache npm
COPY package.json package-lock.json ./
RUN npm ci --prefer-offline

# Copier les sources et builder
COPY . .
RUN npm run build -- --configuration=production

# ── Stage 2 : Nginx ───────────────────────────────────────────────────────────
FROM nginx:1.27-alpine AS runtime

LABEL maintainer="CertifApp <ops@certifapp.com>"
LABEL org.opencontainers.image.title="CertifApp Web PWA"

# Config Nginx SPA (toutes les routes → index.html)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copier le build Angular
COPY --from=builder /app/dist/certif-web /usr/share/nginx/html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD wget -qO- http://localhost/health || exit 1

CMD ["nginx", "-g", "daemon off;"]
