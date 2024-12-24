#!/usr/bin/env bash
set -e

RESULTS="results_c.csv"
echo "Fichier,Statut,Détails" > "$RESULTS"

for file in snippets/c/*.c; do
  [ -e "$file" ] || continue  # Ignore s'il n'y a aucun .c
  base=$(basename "$file" .c)

  echo "==> Compilation de $file ..."
  
  # On redirige la sortie standard et erreur dans un fichier compile.log
  # pour extraire le message en cas d'échec
  if gcc -o "$base" "$file" > compile.log 2>&1; then
    echo "Compilation OK: $base"
    
    # Exécution (vous pouvez aussi capturer la sortie si besoin)
    if ./"$base" > run.log 2>&1; then
      echo "$file,OK," >> "$RESULTS"
    else
      # En cas d'erreur d'exécution, on peut stocker le message
      details=$(head -n 1 run.log)  # par exemple, on prend juste la 1re ligne
      echo "$file,ERREUR_EXECUTION,$details" >> "$RESULTS"
    fi

    rm -f "$base" run.log
  else
    # S'il y a une erreur de compilation, on récupère la 1re ligne d'erreur
    details=$(head -n 1 compile.log)
    echo "$file,ERREUR_COMPILATION,$details" >> "$RESULTS"
  fi
done

# Nettoyage
rm -f compile.log

echo "==> Résultats (C) enregistrés dans $RESULTS"
cat "$RESULTS"
