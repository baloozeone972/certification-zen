# certif-parent/certif-api-rest/Dockerfile
# Multi-stage build — Java 21 (Eclipse Temurin) + Spring Boot 3
# Stage 1 : build Maven (cache des layers)
# Stage 2 : image runtime minimale (~200 MB)

# ── Stage 1 : Builder ─────────────────────────────────────────────────────────
FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /workspace

# Copier les POM.XML pour profiter du cache Maven des dépendances
COPY pom.xml                         ./pom.xml
COPY certif-domain/pom.xml           ./certif-domain/pom.xml
COPY certif-application/pom.xml      ./certif-application/pom.xml
COPY certif-infrastructure/pom.xml   ./certif-infrastructure/pom.xml
COPY certif-api-rest/pom.xml         ./certif-api-rest/pom.xml
COPY certif-ai/pom.xml               ./certif-ai/pom.xml

# Pré-télécharger les dépendances (layer cachée si pom.xml inchangé)
RUN --mount=type=cache,target=/root/.m2 \
    mvn dependency:go-offline -B --no-transfer-progress 2>/dev/null || true

# Copier les sources
COPY certif-domain/src           ./certif-domain/src
COPY certif-application/src      ./certif-application/src
COPY certif-infrastructure/src   ./certif-infrastructure/src
COPY certif-api-rest/src         ./certif-api-rest/src
COPY certif-ai/src               ./certif-ai/src

# Build (sans tests — déjà exécutés par la CI)
RUN --mount=type=cache,target=/root/.m2 \
    mvn -B clean package -DskipTests --no-transfer-progress \
    -pl certif-domain,certif-application,certif-infrastructure,certif-api-rest,certif-ai \
    -am

# Extraire les layers Spring Boot pour un meilleur cache Docker
RUN java -Djarmode=layertools \
    -jar certif-api-rest/target/certif-api-rest-*.jar \
    extract --destination certif-api-rest/target/extracted

# ── Stage 2 : Runtime ─────────────────────────────────────────────────────────
FROM eclipse-temurin:21-jre-alpine AS runtime

LABEL maintainer="CertifApp <ops@certifapp.com>"
LABEL org.opencontainers.image.title="CertifApp API"
LABEL org.opencontainers.image.description="Spring Boot 3 REST API for CertifApp"

# Utilisateur non-root pour la sécurité
RUN addgroup -S certif && adduser -S certif -G certif
USER certif

WORKDIR /app

# Copier les layers Spring Boot extraits (optimise le cache)
COPY --from=builder --chown=certif:certif \
    /workspace/certif-api-rest/target/extracted/dependencies/           ./
COPY --from=builder --chown=certif:certif \
    /workspace/certif-api-rest/target/extracted/spring-boot-loader/     ./
COPY --from=builder --chown=certif:certif \
    /workspace/certif-api-rest/target/extracted/snapshot-dependencies/  ./
COPY --from=builder --chown=certif:certif \
    /workspace/certif-api-rest/target/extracted/application/            ./

# Port exposé par Spring Boot
EXPOSE 8080

# Health check Docker natif (avant que l'orchestrateur le sonde)
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD wget -qO- http://localhost:8080/actuator/health | grep -q '"status":"UP"' || exit 1

# JVM tuned pour conteneur :
# -XX:+UseContainerSupport       → respecte les cgroups CPU/RAM
# -XX:MaxRAMPercentage=75.0      → utilise 75% de la RAM allouée
# -XX:+UseVirtualThreads         → active les Virtual Threads Java 21
# -Djava.security.egd=...        → accélère la génération de tokens JWT
ENTRYPOINT ["java", \
    "-XX:+UseContainerSupport", \
    "-XX:MaxRAMPercentage=75.0", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE:-prod}", \
    "org.springframework.boot.loader.launch.JarLauncher"]
