#!/usr/bin/env bash

set -e
RESULTS="results_python.csv"
echo "Fichier,Statut" > "$RESULTS"

for file in snippets/python/*.py; do
  [ -e "$file" ] || continue
  echo "==> Exécution de $file ..."
  
  if python "$file" > /dev/null 2>error.log; then
    echo "$file,OK" >> "$RESULTS"
  else
    echo "$file,ERREUR_EXECUTION" >> "$RESULTS"
  fi
done

echo "==> Résultats (Python) enregistrés dans $RESULTS"
cat "$RESULTS"
