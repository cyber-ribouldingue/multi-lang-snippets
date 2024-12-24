#!/usr/bin/env bash
set -e

RESULT_FILE="results_cpp.csv"
echo "Fichier,Statut" > "$RESULT_FILE"

for snippet in snippets/cpp/*.cpp; do
    [ -e "$snippet" ] || continue

    echo "Compilation de $snippet..."
    file_name=$(basename "$snippet" .cpp)

    if g++ -o "$file_name" "$snippet"; then
        echo "- Compilation OK. Exécution..."
        if ./"$file_name"; then
            echo "$snippet,OK" >> "$RESULT_FILE"
        else
            echo "$snippet,ERREUR_A_L_EXECUTION" >> "$RESULT_FILE"
        fi
    else
        echo "$snippet,ERREUR_DE_COMPILATION" >> "$RESULT_FILE"
    fi

    echo ""
done

echo "Résultats enregistrés dans $RESULT_FILE"
