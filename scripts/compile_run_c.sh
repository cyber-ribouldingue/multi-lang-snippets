#!/usr/bin/env bash
set -e  # arrête si erreur de commande

# Création d'un fichier CSV pour consigner les résultats
RESULT_FILE="results_c.csv"
echo "Fichier,Statut" > "$RESULT_FILE"

# Parcourt tous les fichiers .c du dossier snippets/c/
for snippet in snippets/c/*.c; do
    # Si aucun fichier n'existe, "continue" évite une erreur
    [ -e "$snippet" ] || continue

    echo "Compilation de $snippet..."

    # On récupère juste le nom de base, sans extension
    file_name=$(basename "$snippet" .c)

    # On compile avec gcc
    if gcc -o "$file_name" "$snippet"; then
        # Si la compilation réussit, on exécute pour vérifier qu'il n'y a pas d'erreur
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
