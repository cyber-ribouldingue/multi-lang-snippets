#!/usr/bin/env bash

set -e  # Stop on error
RESULTS="results_c.csv"
echo "Fichier,Statut" > "$RESULTS"

for file in snippets/c/*.c; do
  [ -e "$file" ] || continue  # Ignore si pas de fichier
  base=$(basename "$file" .c)
  echo "==> Compilation de $file ..."

  if gcc -o "$base" "$file"; then
    echo "- Compilation OK"
    
    # Exécution simple
    if ./"$base" > "$base.out" 2>"$base.err"; then
      echo "$file,OK" >> "$RESULTS"
    else
      echo "$file,ERREUR_EXECUTION" >> "$RESULTS"
    fi

    rm -f "$base" "$base.out" "$base.err"
  else
    echo "$file,ERREUR_COMPILATION" >> "$RESULTS"
  fi
done

echo "==> Résultats (C) enregistrés dans $RESULTS"
cat "$RESULTS"
