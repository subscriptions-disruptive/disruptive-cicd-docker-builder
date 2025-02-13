#!/bin/bash
set -e

if [[ -f "/secrets/token" ]]; then
  GITHUB_TOKEN=$(cat /secrets/token)
else
  echo "Error: No se encontró el token en /secrets/token"
  exit 1
fi

# Validar variables requeridas
if [[ -z "$RUNNER_ORG" || -z "$GITHUB_TOKEN" ]]; then
  echo "Error: RUNNER_ORG y GITHUB_TOKEN son requeridos."
  exit 1
fi

# Configurar el runner para la organización
./config.sh --url "https://github.com/${RUNNER_ORG}" --token "$GITHUB_TOKEN" --name "$RUNNER_NAME" --labels "$RUNNER_LABELS" --unattended

# Capturar señales y apagar correctamente el runner
cleanup() {
  echo "Deteniendo runner..."
  ./config.sh remove --unattended
  exit 0
}
trap cleanup SIGINT SIGTERM

# Iniciar el runner
exec ./run.sh
