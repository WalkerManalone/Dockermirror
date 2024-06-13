version: '3'

services:
  traefik:
    image: traefik:v2.4
    command:
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--entrypoints.web.address=:80"
    ports:
      - "80:80"
      - "8080:8080"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    networks:
      - traefik

  google-translate:
    image: your-proxy-image
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.translate.rule=Host(`zh.m.wikipedia.org`)"
      - "traefik.http.services.translate.loadbalancer.server.port=80"
    networks:
      - traefik

networks:
  traefik:
    external: true
