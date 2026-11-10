#!/usr/bin/env bash
set -euo pipefail

IMAGE='webgoat/webgoat:v2025.3'
CONTAINER='webgoat-lab'
URL='http://127.0.0.1:8080/WebGoat'

if ! command -v docker >/dev/null 2>&1 || ! command -v sudo >/dev/null 2>&1; then
  echo 'Erro: este script precisa de Docker e sudo na VM Kali Linux.' >&2
  exit 1
fi
if ! command -v curl >/dev/null 2>&1; then
  echo 'Erro: instale curl na VM Kali Linux.' >&2
  exit 1
fi
if ! sudo docker info >/dev/null; then
  echo 'Erro: o serviço Docker não está acessível na VM Kali Linux.' >&2
  exit 1
fi

if sudo docker container inspect "$CONTAINER" >/dev/null 2>&1; then
  current_image=$(sudo docker inspect --format '{{.Config.Image}}' "$CONTAINER")
  port_8080=$(sudo docker inspect --format '{{(index (index .HostConfig.PortBindings "8080/tcp") 0).HostIp}}:{{(index (index .HostConfig.PortBindings "8080/tcp") 0).HostPort}}' "$CONTAINER" 2>/dev/null || true)
  port_9090=$(sudo docker inspect --format '{{(index (index .HostConfig.PortBindings "9090/tcp") 0).HostIp}}:{{(index (index .HostConfig.PortBindings "9090/tcp") 0).HostPort}}' "$CONTAINER" 2>/dev/null || true)
  if [[ "$current_image" != "$IMAGE" || "$port_8080" != '127.0.0.1:8080' || "$port_9090" != '127.0.0.1:9090' ]]; then
    echo "Erro: o container $CONTAINER já existe com outra imagem ou portas." >&2
    echo 'Confira com: sudo docker inspect webgoat-lab' >&2
    echo 'Se não precisar dos dados desse container, remova-o manualmente com: sudo docker rm -f webgoat-lab' >&2
    exit 1
  fi
  if [[ $(sudo docker inspect --format '{{.State.Running}}' "$CONTAINER") != 'true' ]]; then
    sudo docker start "$CONTAINER" >/dev/null
  fi
else
  sudo docker run -d \
    --name "$CONTAINER" \
    -p 127.0.0.1:8080:8080 \
    -p 127.0.0.1:9090:9090 \
    -e TZ=America/Sao_Paulo \
    "$IMAGE" >/dev/null
fi

echo 'Aguardando o WebGoat iniciar...'
for ((attempt=1; attempt<=60; attempt++)); do
  if curl --fail --silent --show-error --output /dev/null --max-time 2 "$URL" 2>/dev/null; then
    echo "WebGoat pronto: $URL"
    echo 'Abra esse endereço no navegador integrado do Burp Suite.'
    exit 0
  fi
  sleep 2
done

echo 'O container iniciou, mas o WebGoat não respondeu em até 2 minutos.' >&2
echo 'Confira os registros com: sudo docker logs webgoat-lab' >&2
exit 1
