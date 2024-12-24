#!/usr/bin/env bash
set -e

RESULT_FILE="results_python.csv"
echo "Fichier,Statut" > "$RESULT_FILE"

for snippet in snippets/python/*.py; do
    [ -e "$snippet" ] || continue

    echo "Exécution de $snippet..."
    if python "$snippet"; then
        echo "$snippet,OK" >> "$RESULT_FILE"
    else
        echo "$snippet,ERREUR_A_L_EXECUTION" >> "$RESULT_FILE"
    fi

    echo ""
done

echo "Résultats enregistrés dans $RESULT_FILE"
