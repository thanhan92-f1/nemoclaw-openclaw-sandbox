#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

SCRIPT_NAME="$(basename "$0")"
MANAGED_MARKER="# Managed by ${SCRIPT_NAME} from https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox.git"
REPO_URL_DEFAULT="https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox.git"
OPENSHELL_INSTALL_URL_DEFAULT="https://raw.githubusercontent.com/NVIDIA/OpenShell/main/install.sh"
NEMOCLAW_INSTALL_URL_DEFAULT="https://nvidia.com/nemoclaw.sh"

ACTION="${1:-help}"
if [[ $# -gt 0 ]]; then
  shift
fi

REPO_URL="${REPO_URL:-$REPO_URL_DEFAULT}"
REPO_DIR="${REPO_DIR:-/opt/nemoclaw-openclaw-sandbox}"
REPO_REF="${REPO_REF:-main}"
OPENSHELL_INSTALL_URL="${OPENSHELL_INSTALL_URL:-$OPENSHELL_INSTALL_URL_DEFAULT}"
NEMOCLAW_INSTALL_URL="${NEMOCLAW_INSTALL_URL:-$NEMOCLAW_INSTALL_URL_DEFAULT}"
SANDBOX_NAME="${SANDBOX_NAME:-nemoclaw-sandbox}"
DOMAIN="${DOMAIN:-}"
INSTALL_CADDY=1
WRITE_SERVICE=1
START_SERVICE=0
RUN_ONBOARD=0
YES=0
PURGE_REPO=0
REMOVE_CADDY_CONFIG=0

log() {
  printf '[INFO] %s\n' "$*"
}

warn() {
  printf '[WARN] %s\n' "$*" >&2
}

die() {
  printf '[ERROR] %s\n' "$*" >&2
  exit 1
}

on_error() {
  local exit_code=$?
  printf '[ERROR] Command failed with exit code %s at line %s: %s\n' "$exit_code" "$1" "$2" >&2
  exit "$exit_code"
}
trap 'on_error "$LINENO" "$BASH_COMMAND"' ERR

usage() {
  cat <<EOF
Usage:
  ${SCRIPT_NAME} install [options]
  ${SCRIPT_NAME} update [options]
  ${SCRIPT_NAME} uninstall [options]
  ${SCRIPT_NAME} repo-sync [options]
  ${SCRIPT_NAME} help

Actions:
  install      Install or refresh host prerequisites and sync this repository.
  update       Sync the repository ref again and re-run the install steps.
  uninstall    Remove repo-managed service/config blocks and optionally remove the repo checkout.
  repo-sync    Clone or update the repository checkout only.
  help         Show this help text.

Options:
  --repo-url URL              Repository URL to clone or sync.
  --repo-dir PATH             Repository checkout directory. Default: /opt/nemoclaw-openclaw-sandbox
  --repo-ref REF              Branch, tag, or commit to check out. Default: main
  --domain NAME               Domain or subdomain for Caddy.
  --sandbox-name NAME         Sandbox name used in service templates. Default: nemoclaw-sandbox
  --skip-caddy                Skip Caddy installation and configuration.
  --skip-service              Skip creating the systemd reconnect service.
  --start-service             Start and enable the systemd reconnect service after writing it.
  --run-onboard               Launch `nemoclaw onboard` at the end of install or update.
  --yes                       Skip uninstall confirmation prompts.
  --purge-repo                With uninstall, remove the synced repository directory.
  --remove-caddy-config       With uninstall, remove a Caddyfile written by this script.
  --help                      Show this help text.

Environment overrides:
  REPO_URL                    Same as --repo-url
  REPO_DIR                    Same as --repo-dir
  REPO_REF                    Same as --repo-ref
  DOMAIN                      Same as --domain
  SANDBOX_NAME                Same as --sandbox-name
  OPENSHELL_INSTALL_URL       Override the OpenShell installer URL for pinning or rollback.
  NEMOCLAW_INSTALL_URL        Override the NemoClaw installer URL for pinning or rollback.

Examples:
  sudo bash ${SCRIPT_NAME} install --domain sandbox.example.cloud
  sudo bash ${SCRIPT_NAME} update --repo-ref v0.1.0
  sudo OPENSHELL_INSTALL_URL=https://example.com/openshell-install.sh \
       NEMOCLAW_INSTALL_URL=https://example.com/nemoclaw-install.sh \
       bash ${SCRIPT_NAME} install --repo-ref v0.1.0
  sudo bash ${SCRIPT_NAME} uninstall --purge-repo --remove-caddy-config --yes
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --repo-url)
        REPO_URL="$2"
        shift 2
        ;;
      --repo-dir)
        REPO_DIR="$2"
        shift 2
        ;;
      --repo-ref)
        REPO_REF="$2"
        shift 2
        ;;
      --domain)
        DOMAIN="$2"
        shift 2
        ;;
      --sandbox-name)
        SANDBOX_NAME="$2"
        shift 2
        ;;
      --skip-caddy)
        INSTALL_CADDY=0
        shift
        ;;
      --skip-service)
        WRITE_SERVICE=0
        shift
        ;;
      --start-service)
        START_SERVICE=1
        shift
        ;;
      --run-onboard)
        RUN_ONBOARD=1
        shift
        ;;
      --yes)
        YES=1
        shift
        ;;
      --purge-repo)
        PURGE_REPO=1
        shift
        ;;
      --remove-caddy-config)
        REMOVE_CADDY_CONFIG=1
        shift
        ;;
      --help|-h)
        usage
        exit 0
        ;;
      *)
        die "Unknown argument: $1"
        ;;
    esac
  done
}

ensure_root() {
  [[ "$EUID" -eq 0 ]] || die "Run this script as root or with sudo."
}

ensure_apt() {
  command -v apt-get >/dev/null 2>&1 || die "This script currently supports Ubuntu or Debian with apt-get."
}

target_user() {
  if [[ -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
    printf '%s' "$SUDO_USER"
  else
    printf 'root'
  fi
}

target_home() {
  local user
  user="$(target_user)"
  getent passwd "$user" | cut -d: -f6
}

apt_update_once() {
  if [[ -z "${APT_UPDATED:-}" ]]; then
    log "Updating apt package metadata"
    apt-get update -y
    APT_UPDATED=1
  fi
}

apt_install() {
  apt_update_once
  DEBIAN_FRONTEND=noninteractive apt-get install -y "$@"
}

backup_if_unmanaged() {
  local file_path="$1"
  if [[ -f "$file_path" ]] && ! grep -Fq "$MANAGED_MARKER" "$file_path"; then
    local backup_path
    backup_path="${file_path}.backup.$(date +%Y%m%d%H%M%S)"
    cp "$file_path" "$backup_path"
    warn "Backed up existing unmanaged file to ${backup_path}"
  fi
}

append_block_if_missing() {
  local file_path="$1"
  local begin_marker="$2"
  local end_marker="$3"
  local content="$4"

  mkdir -p "$(dirname "$file_path")"
  touch "$file_path"

  if grep -Fq "$begin_marker" "$file_path"; then
    return 0
  fi

  {
    printf '\n%s\n' "$begin_marker"
    printf '%s\n' "$content"
    printf '%s\n' "$end_marker"
  } >> "$file_path"
}

remove_block_if_present() {
  local file_path="$1"
  local begin_marker="$2"
  local end_marker="$3"
  local tmp_file

  [[ -f "$file_path" ]] || return 0
  tmp_file="$(mktemp)"
  awk -v begin="$begin_marker" -v end="$end_marker" '
    $0 == begin { skip = 1; next }
    $0 == end { skip = 0; next }
    !skip { print }
  ' "$file_path" > "$tmp_file"
  mv "$tmp_file" "$file_path"
}

checkout_repo_ref() {
  if git -C "$REPO_DIR" show-ref --verify --quiet "refs/remotes/origin/$REPO_REF"; then
    git -C "$REPO_DIR" checkout -B "$REPO_REF" "origin/$REPO_REF"
  else
    git -C "$REPO_DIR" checkout -f "$REPO_REF"
  fi
}

sync_repository() {
  log "Syncing repository from ${REPO_URL} into ${REPO_DIR} at ref ${REPO_REF}"
  apt_install git ca-certificates
  mkdir -p "$(dirname "$REPO_DIR")"

  if [[ -d "$REPO_DIR/.git" ]]; then
    git -C "$REPO_DIR" remote set-url origin "$REPO_URL"
    git -C "$REPO_DIR" fetch --tags --prune origin
  else
    git clone "$REPO_URL" "$REPO_DIR"
    git -C "$REPO_DIR" fetch --tags --prune origin
  fi

  checkout_repo_ref
}

install_base_packages() {
  log "Installing base packages"
  apt_install curl git ca-certificates gnupg
}

install_docker() {
  log "Installing or refreshing Docker"
  curl -fsSL https://get.docker.com | sh
  systemctl enable docker
  systemctl restart docker
}

configure_docker_cgroup() {
  log "Configuring Docker cgroup namespace mode"
  mkdir -p /etc/docker
  cat > /etc/docker/daemon.json <<'EOF'
{"default-cgroupns-mode": "host"}
EOF
  systemctl restart docker
}

write_bashrc_block() {
  local home_dir="$1"
  local bashrc_file="$home_dir/.bashrc"
  local begin_marker="# BEGIN NEMOCLAW OPENCLAW MANAGED PATH"
  local end_marker="# END NEMOCLAW OPENCLAW MANAGED PATH"
  local content

  content=$(cat <<'EOF'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
export PATH="$PATH:$HOME/.local/bin"
EOF
)

  append_block_if_missing "$bashrc_file" "$begin_marker" "$end_marker" "$content"
}

install_openshell() {
  log "Installing or refreshing OpenShell from ${OPENSHELL_INSTALL_URL}"
  curl -LsSf "$OPENSHELL_INSTALL_URL" | sh
}

install_nemoclaw() {
  local home_dir="$1"
  log "Installing or refreshing NemoClaw from ${NEMOCLAW_INSTALL_URL}"
  export HOME="$home_dir"
  export NVM_DIR="$home_dir/.nvm"
  if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    # shellcheck disable=SC1090
    . "$NVM_DIR/nvm.sh"
  fi
  curl -fsSL "$NEMOCLAW_INSTALL_URL" | bash
}

write_ssh_keepalive() {
  local home_dir="$1"
  local ssh_dir="$home_dir/.ssh"
  local ssh_config="$ssh_dir/config"
  local begin_marker="# BEGIN NEMOCLAW OPENCLAW MANAGED SSH KEEPALIVE"
  local end_marker="# END NEMOCLAW OPENCLAW MANAGED SSH KEEPALIVE"
  local content

  mkdir -p "$ssh_dir"
  chmod 700 "$ssh_dir"

  content=$(cat <<'EOF'
Host *
  ServerAliveInterval 30
  ServerAliveCountMax 3
  TCPKeepAlive yes
EOF
)

  append_block_if_missing "$ssh_config" "$begin_marker" "$end_marker" "$content"
  chmod 600 "$ssh_config"
}

install_caddy() {
  log "Installing or refreshing Caddy"
  mkdir -p /usr/share/keyrings /etc/apt/sources.list.d
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' > /etc/apt/sources.list.d/caddy-stable.list
  apt_update_once
  DEBIAN_FRONTEND=noninteractive apt-get install -y caddy
}

write_caddyfile() {
  [[ -n "$DOMAIN" ]] || {
    warn "Skipping Caddyfile creation because no domain was provided."
    return 0
  }

  local caddyfile="/etc/caddy/Caddyfile"
  backup_if_unmanaged "$caddyfile"

  log "Writing Caddy configuration for ${DOMAIN}"
  cat > "$caddyfile" <<EOF
${MANAGED_MARKER}
${DOMAIN} {
  reverse_proxy 127.0.0.1:18789 {
    header_up Host 127.0.0.1:18789
    header_up Origin http://127.0.0.1:18789
  }
}
EOF

  systemctl enable caddy
  systemctl restart caddy
}

find_binary() {
  local binary_name="$1"
  local home_dir="$2"
  local binary_path

  binary_path="$(HOME="$home_dir" bash -lc "source '$home_dir/.bashrc' >/dev/null 2>&1 || true; command -v $binary_name" 2>/dev/null || true)"
  [[ -n "$binary_path" ]] || die "Unable to find binary: ${binary_name}. Re-open the shell and retry."
  printf '%s' "$binary_path"
}

write_systemd_service() {
  local home_dir="$1"
  local service_file="/etc/systemd/system/nemoclaw-connect.service"
  local nemoclaw_bin
  local openshell_bin
  local managed_path

  nemoclaw_bin="$(find_binary nemoclaw "$home_dir")"
  openshell_bin="$(find_binary openshell "$home_dir")"
  managed_path="$(dirname "$nemoclaw_bin"):$(dirname "$openshell_bin"):/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

  backup_if_unmanaged "$service_file"

  log "Writing systemd reconnect service for sandbox ${SANDBOX_NAME}"
  cat > "$service_file" <<EOF
${MANAGED_MARKER}
[Unit]
Description=NemoClaw Gateway Connection
After=network-online.target docker.service
Wants=network-online.target docker.service

[Service]
Type=simple
User=root
Environment=PATH=${managed_path}
ExecStartPre=/bin/bash -c 'until ${openshell_bin} status 2>/dev/null | grep -q Connected; do sleep 5; done'
ExecStart=${nemoclaw_bin} ${SANDBOX_NAME} connect
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

  systemctl daemon-reload

  if (( START_SERVICE )); then
    systemctl enable --now nemoclaw-connect
  else
    log "Service file written. Start it later with: systemctl enable --now nemoclaw-connect"
  fi
}

run_onboard_if_requested() {
  local home_dir="$1"
  if (( RUN_ONBOARD )); then
    log "Launching the interactive NemoClaw onboarding wizard"
    HOME="$home_dir" bash -lc "source '$home_dir/.bashrc' >/dev/null 2>&1 || true; nemoclaw onboard"
  fi
}

print_post_install() {
  cat <<EOF

Next steps:
  1. If not already completed, run: nemoclaw onboard
  2. Start the sandbox connection: nemoclaw ${SANDBOX_NAME} connect
  3. If you created the service file and the sandbox already exists, enable it with:
     systemctl enable --now nemoclaw-connect
  4. Register providers and configure OpenClaw as documented in INSTALL.md

Repository sync details:
  Repo URL: ${REPO_URL}
  Repo dir: ${REPO_DIR}
  Repo ref: ${REPO_REF}

Pinning or rollback:
  - Use --repo-ref to switch repository docs/config snapshots.
  - Override OPENSHELL_INSTALL_URL or NEMOCLAW_INSTALL_URL to point to a pinned installer when upstream publishes versioned installers.
EOF
}

perform_install() {
  local home_dir
  ensure_root
  ensure_apt
  home_dir="$(target_home)"

  install_base_packages
  sync_repository
  write_bashrc_block "$home_dir"
  install_docker
  configure_docker_cgroup
  install_openshell
  install_nemoclaw "$home_dir"
  write_bashrc_block "$home_dir"
  write_ssh_keepalive "$home_dir"

  if (( INSTALL_CADDY )); then
    install_caddy
    write_caddyfile
  fi

  if (( WRITE_SERVICE )); then
    write_systemd_service "$home_dir"
  fi

  run_onboard_if_requested "$home_dir"
  print_post_install
}

perform_uninstall() {
  local home_dir
  local bashrc_begin="# BEGIN NEMOCLAW OPENCLAW MANAGED PATH"
  local bashrc_end="# END NEMOCLAW OPENCLAW MANAGED PATH"
  local ssh_begin="# BEGIN NEMOCLAW OPENCLAW MANAGED SSH KEEPALIVE"
  local ssh_end="# END NEMOCLAW OPENCLAW MANAGED SSH KEEPALIVE"
  local service_file="/etc/systemd/system/nemoclaw-connect.service"
  local caddyfile="/etc/caddy/Caddyfile"

  ensure_root
  home_dir="$(target_home)"

  if (( ! YES )); then
    printf 'This removes repo-managed service files and shell config blocks. Continue? [y/N] '
    read -r reply
    [[ "$reply" =~ ^[Yy]$ ]] || die "Uninstall aborted."
  fi

  if systemctl list-unit-files | grep -q '^nemoclaw-connect.service'; then
    systemctl disable --now nemoclaw-connect || true
  fi

  if [[ -f "$service_file" ]] && grep -Fq "$MANAGED_MARKER" "$service_file"; then
    rm -f "$service_file"
    systemctl daemon-reload
    log "Removed managed systemd service"
  fi

  remove_block_if_present "$home_dir/.bashrc" "$bashrc_begin" "$bashrc_end"
  remove_block_if_present "$home_dir/.ssh/config" "$ssh_begin" "$ssh_end"

  if (( REMOVE_CADDY_CONFIG )) && [[ -f "$caddyfile" ]] && grep -Fq "$MANAGED_MARKER" "$caddyfile"; then
    rm -f "$caddyfile"
    systemctl restart caddy || true
    log "Removed managed Caddy configuration"
  fi

  if (( PURGE_REPO )) && [[ -d "$REPO_DIR" ]]; then
    rm -rf "$REPO_DIR"
    log "Removed repository checkout at ${REPO_DIR}"
  fi

  cat <<EOF

Uninstall finished.

Manual follow-up, if desired:
  - Remove or reconfigure Docker, OpenShell, NemoClaw, or Caddy separately.
  - Remove provider credentials from the host if they are no longer needed.
  - Remove sandboxes explicitly only if you intend to delete runtime state.
EOF
}

parse_args "$@"

case "$ACTION" in
  install)
    perform_install
    ;;
  update)
    perform_install
    ;;
  uninstall)
    perform_uninstall
    ;;
  repo-sync)
    ensure_root
    ensure_apt
    sync_repository
    ;;
  help|-h|--help)
    usage
    ;;
  *)
    usage
    die "Unknown action: ${ACTION}"
    ;;
esac
