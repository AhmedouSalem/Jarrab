#!/bin/bash

echo "===================================="
echo "📁 STRUCTURE DU DOSSIER lib/"
echo "===================================="
find lib -maxdepth 4 -type d | sed 's|[^/]*/|  |g'

echo ""
echo "===================================="
echo "🚪 POINT D’ENTRÉE"
echo "===================================="
ls -1 lib/main.dart lib/app.dart 2>/dev/null

echo ""
echo "===================================="
echo "🧭 ROUTING"
echo "===================================="
find lib -maxdepth 3 -type f \( -name "*router*.dart" -o -name "*routes*.dart" \)

echo ""
echo "===================================="
echo "🎨 THEME & UI CORE"
echo "===================================="
find lib/core -type f \( -name "*theme*.dart" -o -name "*responsive*.dart" -o -name "*layout*.dart" \)

echo ""
echo "===================================="
echo "🌍 INTERNATIONALISATION (i18n)"
echo "===================================="
find lib -type d -name "l10n"
find lib -type f -name "*.arb"

echo ""
echo "===================================="
echo "🧩 FEATURES"
echo "===================================="
find lib/features -maxdepth 2 -type d

echo ""
echo "===================================="
echo "🧠 STATE / LOGIQUE UI"
echo "===================================="
find lib -type f \( -name "*state*.dart" -o -name "*form*.dart" -o -name "*bloc*.dart" -o -name "*cubit*.dart" \)

echo ""
echo "===================================="
echo "🧱 WIDGETS RÉUTILISABLES"
echo "===================================="
find lib -type d -name "widgets"

echo ""
echo "===================================="
echo "📜 CONVENTIONS (noms des fichiers)"
echo "===================================="
find lib -type f | sed 's|.*/||' | sort | uniq -c | sort -nr | head -20

echo ""
echo "===================================="
echo "✅ FIN DE L’INSPECTION"
echo "===================================="
