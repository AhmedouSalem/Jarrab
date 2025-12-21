#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-lib}"

if [[ ! -d "$ROOT" ]]; then
  echo "❌ Dossier introuvable: $ROOT"
  exit 1
fi

# Ignore generated files (adapter si besoin)
IGNORE_REGEX='(\.g\.dart$|\.freezed\.dart$|\.gen\.dart$|\.mocks\.dart$|/\.dart_tool/|/build/)'

print_header() {
  echo
  echo "===================================="
  echo "$1"
  echo "===================================="
}

print_tree_fallback() {
  find "$ROOT" \
    | grep -Ev "$IGNORE_REGEX" \
    | sort \
    | awk -v root="$ROOT" '
      BEGIN { rootlen=length(root); }
      {
        path=$0
        sub("^" root "/?", "", path)
        if (path == "") { print root; next }
        n=gsub("/", "/", path)
        indent=""
        for (i=0; i<n; i++) indent=indent "  "
        print indent path
      }'
}

print_paths_regex() {
  local title="$1"
  local regex="$2"
  print_header "$title"
  local out
  out="$(find "$ROOT" -type f -regextype posix-extended -regex "$regex" 2>/dev/null \
    | grep -Ev "$IGNORE_REGEX" | sort || true)"
  if [[ -z "$out" ]]; then
    echo "(rien trouvé)"
  else
    echo "$out"
  fi
}

print_dirs_regex() {
  local title="$1"
  local regex="$2"
  print_header "$title"
  local out
  out="$(find "$ROOT" -type d -regextype posix-extended -regex "$regex" 2>/dev/null \
    | grep -Ev "$IGNORE_REGEX" | sort || true)"
  if [[ -z "$out" ]]; then
    echo "(rien trouvé)"
  else
    echo "$out"
  fi
}

print_header "📁 STRUCTURE DU DOSSIER $ROOT/"

if command -v tree >/dev/null 2>&1; then
  tree -a "$ROOT" \
    -I ".dart_tool|build|.git|*.g.dart|*.freezed.dart|*.gen.dart|*.mocks.dart"
else
  print_tree_fallback
fi

print_paths_regex "🚪 POINT D’ENTRÉE" ".*/main\\.dart$"
print_paths_regex "🚪 APP ROOT" ".*/app\\.dart$"

print_paths_regex "🧭 ROUTING (routes.dart)" ".*/routes\\.dart$"
print_paths_regex "🧭 ROUTING (app_router.dart)" ".*/app_router\\.dart$"

print_dirs_regex "🌍 INTERNATIONALISATION (i18n)" ".*/l10n$|.*/l10n/.*"
print_dirs_regex "🎨 THEME" ".*/theme$|.*/theme/.*"

print_dirs_regex "🧩 FEATURES" ".*/features$|.*/features/[^/]+$"
print_dirs_regex "🧠 BUSINESS LOGIC" ".*/features/[^/]+/business_logic$|.*/features/[^/]+/business_logic/.*"
print_dirs_regex "🗄️ DATA" ".*/features/[^/]+/data$|.*/features/[^/]+/data/.*"
print_dirs_regex "🧱 PRESENTATION" ".*/features/[^/]+/presentation$|.*/features/[^/]+/presentation/.*"

# ✅ Fichiers
print_paths_regex "🧠 FICHIERS BLoC/Cubit" ".*/features/[^/]+/business_logic/(bloc|cubit)/.*\\.dart$|.*/features/[^/]+/business_logic/.*/(bloc|cubit)/.*\\.dart$"
print_paths_regex "🗃️ REPOSITORIES" ".*/features/[^/]+/data/repositories/.*\\.dart$"
print_paths_regex "🔌 SERVICES" ".*/features/[^/]+/data/services/.*\\.dart$"
print_paths_regex "📦 MODELS (data/models)" ".*/features/[^/]+/data/models/.*\\.dart$"

print_header "✅ FIN DE L’INSPECTION"
